//
//  RNMenulet.h
//  RSSNotify
//
//  Created by Brian Rogers on 3/25/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RNMenulet : NSObject {
    NSStatusItem *statusItem;
}

@property (weak) IBOutlet NSMenu *statusItemMenu;
- (IBAction)settingsMenuItemClicked:(id)sender;
- (IBAction)refreshMenuItemClicked:(id)sender;

@end
