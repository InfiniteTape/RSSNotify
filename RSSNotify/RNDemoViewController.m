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
    NSTimer *refreshTimer;
}
@end

@implementation RNDemoViewController

@synthesize demoTextView;
@synthesize refreshTimeTextField;
@synthesize demoButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    refreshTimeTextField.integerValue = settings.refreshTime;
}

-(void)loadSettings {
    settings = [[RNSettings alloc] init];
    [settings load];
    // Temporary feed list until the settings dialog is off the ground
    if([settings.feedList count] == 0) {
        [settings.feedList addObject:@"http://feeds.gawker.com/Gizmodo/full"];
        [settings.feedList addObject:@"http://feeds.gawker.com/Kotaku/full"];
    }
    // TODO: once the refresh time comes only from the settings, just call updateFeeds... here.
    model.feeds = settings.feedList;
    model.maxEntries = settings.maxEntries;
}

-(void)updateFeeds:(NSArray *)feedList
           andTime:(NSInteger)refreshTime
            andMax:(NSInteger)maxInteger {
    model.feeds = feedList;
    refreshTimeTextField.integerValue = refreshTime;
    model.maxEntries = settings.maxEntries;
}

-(IBAction)demoButtonClicked:(id)sender
{
    int timeInt = [refreshTimeTextField intValue];
    //[demoTextView setString:@""];
    [self updateFeeds];
    refreshTimer = [NSTimer scheduledTimerWithTimeInterval:timeInt
                                                    target:self
                                                  selector:@selector(updateFeeds)
                                                  userInfo:nil
                                                   repeats:YES];
    if(refreshTimer)
        [demoButton setEnabled:NO];
}

- (IBAction)settingsButtonClicked:(id)sender {
    RNSettingsWindowController *settingsWindow = [[RNSettingsWindowController alloc] initWithWindowNibName:@"RNSettingsWindowController"];
    settingsWindow.feedList = [model.feeds copy];
    NSModalSession session = [[NSApplication sharedApplication] beginModalSessionForWindow: settingsWindow.window];
    [settingsWindow.refreshTimeTextField setIntegerValue:self.refreshTimeTextField.integerValue];
    [settingsWindow.maxEntriesTextField setIntegerValue:model.maxEntries];
    NSInteger result = [[NSApplication sharedApplication]runModalForWindow:settingsWindow.window];
    if(!result) {
        [self loadSettings];
    }
    else {
        [self updateFeeds:model.feeds
                  andTime:settingsWindow.refreshTimeTextField.integerValue
                   andMax:settingsWindow.maxEntriesTextField.integerValue];
    }
    [[NSApplication sharedApplication] endModalSession:session];
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
