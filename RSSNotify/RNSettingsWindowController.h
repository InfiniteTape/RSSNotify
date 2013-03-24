//
//  RNSettingsWindowController.h
//  RSSNotify
//
//  Created by Brian Rogers on 3/22/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RNSettingsWindowController : NSWindowController <NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate>
@property (strong, atomic) NSMutableArray *feedList;
@property (weak) IBOutlet NSTextField *refreshTimeTextField;
- (IBAction)okButtonPressed:(id)sender;
@property (weak) IBOutlet NSTextField *maxEntriesTextField;
- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)addButtonClicked:(id)sender;
- (IBAction)removeButtonClicked:(id)sender;
@property (weak) IBOutlet NSTableView *feedTableView;
@end
