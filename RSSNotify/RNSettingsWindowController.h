//
//  RNSettingsWindowController.h
//  RSSNotify
//
//  Created by Brian Rogers on 3/22/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RNSettingsWindowController : NSWindowController <NSWindowDelegate>
@property (weak) IBOutlet NSTextField *refreshTimeTextField;
- (IBAction)okButtonPressed:(id)sender;
@property (weak) IBOutlet NSTextField *maxEntriesTextField;
@end
