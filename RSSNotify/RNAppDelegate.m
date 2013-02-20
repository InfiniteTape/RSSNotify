//
//  RNAppDelegate.m
//  RSSNotify
//
//  Created by Brian Rogers on 2/17/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "RNAppDelegate.h"
#include "RNDemoViewController.h"

@interface RNAppDelegate()
@property (nonatomic, strong) IBOutlet RNDemoViewController *demoViewController;
@end

@implementation RNAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.demoViewController = [[RNDemoViewController alloc] initWithNibName:@"RNDemoViewController" bundle:nil];
    [self.window.contentView addSubview:self.demoViewController.view];
    self.demoViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

@end
