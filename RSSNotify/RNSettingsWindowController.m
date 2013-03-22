//
//  RNSettingsWindowController.m
//  RSSNotify
//
//  Created by Brian Rogers on 3/22/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "RNSettingsWindowController.h"

@interface RNSettingsWindowController ()

@end

@implementation RNSettingsWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)windowWillClose:(NSNotification *)notification {
    [[NSApplication sharedApplication] stopModalWithCode:0];
}

- (BOOL)windowShouldClose:(NSNotification *)notification {
    return YES;
}

@end
