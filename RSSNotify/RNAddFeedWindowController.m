//
//  RNAddFeedWindowController.m
//  RSSNotify
//
//  Created by Brian Rogers on 3/24/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "RNAddFeedWindowController.h"

@interface RNAddFeedWindowController ()

@end

@implementation RNAddFeedWindowController

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

- (IBAction)cancelButtonClicked:(id)sender {
    [[NSApplication sharedApplication] stopModalWithCode:0];
}

- (IBAction)addButtonClicked:(id)sender {
    [[NSApplication sharedApplication] stopModalWithCode:1];
}
@end
