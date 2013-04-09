//
//  RNMenulet.m
//  RSSNotify
//
//  Created by Brian Rogers on 3/25/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "RNMenulet.h"

@implementation RNMenulet

- (void)awakeFromNib {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setHighlightMode:YES];
    [statusItem setTitle:@"0.0.0.0"];
    [statusItem setEnabled:YES];
    [statusItem setToolTip:@"RNMenulet"];
    [statusItem setMenu:_statusItemMenu];
    
    //[statusItem setAction:@selector(updateIPAddress:)];
    //[statusItem setTarget:self];
}

- (IBAction)settingsMenuItemClicked:(id)sender {
}
@end
