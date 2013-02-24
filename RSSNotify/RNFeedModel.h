//
//  RNFeedModel.h
//  RSSNotify
//
//  Created by Brian Rogers on 2/24/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNDemoViewController.h"

@interface RNFeedModel : NSObject

@property (retain) NSOperationQueue *queue;
@property (retain) NSArray *feeds;
@property (retain) NSString *text;
@property (retain) RNDemoViewController *viewController;

- (void)refresh;

@end
