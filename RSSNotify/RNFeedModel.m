//
//  RNFeedModel.m
//  RSSNotify
//
//  Created by Brian Rogers on 2/24/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "RNFeedModel.h"
#import "RNRSSEntry.h"
#import "ASIHTTPRequest/ASIHTTPRequest.h"
#import "GDataXML/GDataXMLNode.h"
#import "GDataXML/GDataXMLElement-Extras.h"
#import "RNSortedEntries.h"

@implementation RNFeedModel

@synthesize queue;
@synthesize feeds;
@synthesize text;
@synthesize viewController;

-(id)init
{
    self = [super init];
    queue = [[NSOperationQueue alloc] init];
    return self;
}

- (void)refresh
{
    for (NSString *feed in feeds)
    {
        NSURL *url = [NSURL URLWithString:feed];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        [queue addOperation:request];
    }
}

- (void)parseFeed:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries {
    if ([rootElement.name compare:@"rss"] == NSOrderedSame) {
        [self parseRss:rootElement entries:entries];
    } else if ([rootElement.name compare:@"feed"] == NSOrderedSame) {
        [self parseAtom:rootElement entries:entries];
    } else {
        NSLog(@"Unsupported root element: %@", rootElement.name);
    }
}

- (void)parseRss:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries {
    
    NSArray *channels = [rootElement elementsForName:@"channel"];
    for (GDataXMLElement *channel in channels) {
        
        NSString *blogTitle = [channel valueForChild:@"title"];
        
        NSArray *items = [channel elementsForName:@"item"];
        for (GDataXMLElement *item in items) {
            
            NSString *articleTitle = [item valueForChild:@"title"];
            NSString *articleUrl = [item valueForChild:@"link"];
            NSString *articleDateString = [item valueForChild:@"pubDate"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            NSLocale *usLocale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
            [formatter setLocale:usLocale];
            [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
            //NSDate *articleDate = [[NSDate alloc] initWithString:articleDateString];
            
            RNRSSEntry *entry = [[RNRSSEntry alloc] initWithBlogTitle:blogTitle
                                                      articleTitle:articleTitle
                                                        articleUrl:articleUrl
                                                       articleDate:[formatter dateFromString:articleDateString]];
            [entries addObject:entry];
            
        }
    }
    
}

- (void)parseAtom:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries {
    
    NSString *blogTitle = [rootElement valueForChild:@"title"];
    
    NSArray *items = [rootElement elementsForName:@"entry"];
    for (GDataXMLElement *item in items) {
        
        NSString *articleTitle = [item valueForChild:@"title"];
        NSString *articleUrl = nil;
        NSArray *links = [item elementsForName:@"link"];
        for(GDataXMLElement *link in links) {
            NSString *rel = [[link attributeForName:@"rel"] stringValue];
            NSString *type = [[link attributeForName:@"type"] stringValue];
            if ([rel compare:@"alternate"] == NSOrderedSame &&
                [type compare:@"text/html"] == NSOrderedSame) {
                articleUrl = [[link attributeForName:@"href"] stringValue];
            }
        }
        
        NSString *articleDateString = [item valueForChild:@"updated"];
        NSDate *articleDate = [[NSDate alloc] initWithString:articleDateString];
        
        RNRSSEntry *entry = [[RNRSSEntry alloc] initWithBlogTitle:blogTitle
                                                  articleTitle:articleTitle
                                                    articleUrl:articleUrl
                                                   articleDate:articleDate];
        [entries addObject:entry];
        
    }      
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [queue addOperationWithBlock:^{
        NSError *error;
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:request.responseData
                                                               options:0
                                                                 error:&error];
        if(doc==nil)
        {
            NSLog(@"Failed to parse %@", request.url);
        }
        else
        {
            NSMutableArray *entries = [NSMutableArray array];
            RNSortedEntries *sorted = [[RNSortedEntries alloc] initWithMaxSize:(uint)_maxEntries];
            [self parseFeed:doc.rootElement entries:entries];
            for(RNRSSEntry *entry in entries)
            {
                [sorted addEntry:entry];
            }
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSMutableString *buildTitles = [[NSMutableString alloc]init];
                [buildTitles appendFormat:@"%@\n", [NSDate date]];
                uint i;
                for(i=0; i<[sorted getMaxSize]; i++)
                {
                    RNRSSEntry *entry = [sorted getEntryAtIndex:i];
                    [buildTitles appendFormat:@"%@ %@\n", entry.articleTitle, entry.articleDate];
                }
                if(viewController)
                    [viewController updateText:buildTitles];
            }];
        }
        
    }];
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    text = @"Error";
    NSLog(@"Error %@", [request error]);
}

@end
