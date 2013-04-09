//
//  RNMenulet.m
//  RSSNotify
//
//  Created by Brian Rogers on 3/25/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "RNMenulet.h"
#import "RNDemoViewController.h"
#import "RNAppDelegate.h"

@implementation RNMenulet

- (void)awakeFromNib {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setHighlightMode:YES];
    [statusItem setTitle:@"0.0.0.0"];
    [statusItem setEnabled:YES];
    [statusItem setToolTip:@"RNMenulet"];
    [statusItem setMenu:_statusItemMenu];
}

- (IBAction)settingsMenuItemClicked:(id)sender {
    RNAppDelegate *delegate = (RNAppDelegate *)[NSApplication sharedApplication].delegate;
    [delegate.demoViewController settingsButtonClicked:sender];
}

- (IBAction)refreshMenuItemClicked:(id)sender {
    RNAppDelegate *delegate = (RNAppDelegate *)[NSApplication sharedApplication].delegate;
    [delegate.demoViewController updateFeeds];

}
@end
