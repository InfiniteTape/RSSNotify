//
//  RNDemoViewController.m
//  RSSNotify
//
//  Created by Brian Rogers on 2/17/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "RNDemoViewController.h"
#import "RNFeedModel.h"
#import "RNSettings.h"

@interface RNDemoViewController ()
{
    RNFeedModel *model;
    RNSettings *settings;
}
@end



@implementation RNDemoViewController
@synthesize demoTextView;
@synthesize refreshTimeTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        model = [[RNFeedModel alloc] init];
        model.viewController = self;
        //model.feeds = [[NSArray alloc] initWithObjects:
        //               @"http://feeds.gawker.com/Gizmodo/full",
        //               nil];
        settings = [[RNSettings alloc] init];
        [settings load];
        model.feeds = settings.feedList;
        refreshTimeTextField.integerValue = settings.refreshTime;
        model.maxEntries = settings.maxEntries;
    }
    
    return self;
}

-(IBAction)demoButtonClicked:(id)sender
{
    int timeInt = [refreshTimeTextField intValue];
    //[demoTextView setString:@""];
    [self updateFeeds];
    [NSTimer scheduledTimerWithTimeInterval:timeInt
                                     target:self
                                   selector:@selector(updateFeeds)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)updateFeeds
{
    [model refresh];
}

-(void)updateText:(NSString *)text
{
    [demoTextView setString:[[NSString alloc] initWithString:text]];
}

@end
