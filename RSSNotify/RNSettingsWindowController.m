//
//  RNSettingsWindowController.m
//  RSSNotify
//
//  Created by Brian Rogers on 3/22/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "RNSettingsWindowController.h"
#import "RNAddFeedWindowController.h"

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

- (IBAction)okButtonPressed:(id)sender {
    [[NSApplication sharedApplication] stopModalWithCode:1];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _feedList.count;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    // get an existing cell with the MyView identifier if it exists
    NSTableCellView *result = [tableView makeViewWithIdentifier:@"feedCell" owner:self];
    
    // There is no existing cell to reuse so we will create a new one
    if (result == nil) {
        result = [[NSTableCellView alloc] init];
        result.identifier = @"feedCell";
    }
    result.textField.stringValue = [_feedList objectAtIndex:row];
    // return the result.
    return result;
    
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return [_feedList objectAtIndex:row];
}

- (IBAction)cancelButtonClicked:(id)sender {
    [[NSApplication sharedApplication] stopModalWithCode:0];
}

- (IBAction)addButtonClicked:(id)sender {
    RNAddFeedWindowController *addWindow = [[RNAddFeedWindowController alloc] initWithWindowNibName:@"RNAddFeedWindowController"];
    
    NSModalSession session = [[NSApplication sharedApplication] beginModalSessionForWindow: addWindow.window];
    
    NSInteger result = [[NSApplication sharedApplication]runModalForWindow:addWindow.window];
    if(result) {
        if(![_feedList containsObject:addWindow.feedTextField.stringValue]) {
            [_feedList addObject:addWindow.feedTextField.stringValue];
            [_feedTableView reloadData];
        }
    }
    [[NSApplication sharedApplication] endModalSession:session];
}

- (IBAction)removeButtonClicked:(id)sender {
    [_feedList removeObjectAtIndex:_feedTableView.selectedRow];
    [_feedTableView reloadData];
}
@end
