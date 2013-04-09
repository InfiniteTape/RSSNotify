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
#import "RNSettingsWindowController.h"

@interface RNDemoViewController ()
{
    RNFeedModel *model;
    RNSettings *settings;
    NSUInteger refreshTime;
    NSTimer *refreshTimer;
}
@end

@implementation RNDemoViewController

@synthesize demoTextView;
@synthesize demoButton;

+(RNDemoViewController *)sharedInstance {
    return (RNDemoViewController *) self;
}

- (RNDemoViewController *)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        model = [[RNFeedModel alloc] init];
        model.viewController = self;
        [self loadSettings];
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
}

-(void)loadSettings {
    settings = [[RNSettings alloc] init];
    [settings load];
    [self reloadFeeds:settings.feedList andTime:settings.refreshTime andMax:settings.maxEntries];
}

-(void)reloadFeeds:(NSArray *)feedList
           andTime:(NSInteger)newRefreshTime
            andMax:(NSInteger)maxInteger {
    model.feeds = feedList;
    refreshTime = newRefreshTime;
    model.maxEntries = settings.maxEntries;
}

-(IBAction)demoButtonClicked:(id)sender
{
    [self updateFeeds];
    refreshTimer = [NSTimer scheduledTimerWithTimeInterval:refreshTime
                                                    target:self
                                                  selector:@selector(updateFeeds)
                                                  userInfo:nil
                                                   repeats:YES];
    if(refreshTimer)
        [demoButton setEnabled:NO];
}

- (IBAction)settingsButtonClicked:(id)sender {
    RNSettingsWindowController *settingsWindow = [[RNSettingsWindowController alloc] initWithWindowNibName:@"RNSettingsWindowController"];
    settingsWindow.feedList = [[NSMutableArray alloc] initWithArray:model.feeds copyItems:YES];
    NSModalSession session = [[NSApplication sharedApplication] beginModalSessionForWindow: settingsWindow.window];
    [settingsWindow.refreshTimeTextField setIntegerValue:refreshTime];
    [settingsWindow.maxEntriesTextField setIntegerValue:model.maxEntries];
    NSInteger result = [[NSApplication sharedApplication]runModalForWindow:settingsWindow.window];
    if(!result) {
        [self loadSettings];
    }
    else {
        [self reloadFeeds:[settingsWindow.feedList copy]
                  andTime:settingsWindow.refreshTimeTextField.integerValue
                   andMax:settingsWindow.maxEntriesTextField.integerValue];
        settings.feedList = [settingsWindow.feedList copy];
        settings.refreshTime = settingsWindow.refreshTimeTextField.integerValue;
        settings.maxEntries = settingsWindow.maxEntriesTextField.integerValue;
        [settings save];
    }
    [[NSApplication sharedApplication] endModalSession:session];
}

-(void)updateFeeds
{
    [model refresh];
}

-(void)updateText:(NSString *)text
{
    //[demoTextView setString:[[NSString alloc] initWithString:text]];
    [demoTextView setString:[[NSString alloc] initWithFormat:@"%@\n%@", demoTextView.string, text]];
}

@end
