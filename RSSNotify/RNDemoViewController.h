//
//  RNDemoViewController.h
//  RSSNotify
//
//  Created by Brian Rogers on 2/17/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RNDemoViewController : NSViewController

@property (nonatomic, retain) IBOutlet NSTextView *demoTextView;
@property (nonatomic, retain) IBOutlet NSButton *demoButton;
-(IBAction)demoButtonClicked:(id)sender;
-(IBAction)settingsButtonClicked:(id)sender;
-(void) updateFeeds;
-(void) updateText:(NSString *)text;
-(void) runFileTest;
+(RNDemoViewController *)sharedInstance;
@end
