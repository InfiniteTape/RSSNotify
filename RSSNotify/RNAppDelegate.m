//
//  RNAppDelegate.m
//  RSSNotify
//
//  Created by Brian Rogers on 2/17/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "RNAppDelegate.h"
#include "RNMainController.h"

@interface RNAppDelegate()
//@property (nonatomic, strong) IBOutlet RNDemoViewController *demoViewController;
@end

@implementation RNAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /*self.mainController = [[RNMainController alloc] initWithNibName:@"RNMainController" bundle:nil];
    [self.window.contentView addSubview:self.mainController.view];
    self.mainController.view.frame = ((NSView*)self.window.contentView).bounds;*/
    self.mainController = [[RNMainController alloc] init];
}

@end
