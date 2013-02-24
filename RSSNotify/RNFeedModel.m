//
//  RNFeedModel.m
//  RSSNotify
//
//  Created by Brian Rogers on 2/24/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "RNFeedModel.h"
#import "ASIHTTPRequest/ASIHTTPRequest.h"

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

- (void)requestFinished:(ASIHTTPRequest *)request
{
    text = request.responseString;
    if(viewController)
        [viewController updateText:text];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    text = @"Error";
    NSLog(@"Error %@", [request error]);
}

@end
