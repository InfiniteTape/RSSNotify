//
//  RNAddFeedWindowController.h
//  RSSNotify
//
//  Created by Brian Rogers on 3/24/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RNAddFeedWindowController : NSWindowController <NSWindowDelegate>

@property (weak) IBOutlet NSTextField *feedTextField;
- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)addButtonClicked:(id)sender;
@end
