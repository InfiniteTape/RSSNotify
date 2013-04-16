//
//  RNFeedModel.h
//  RSSNotify
//
//  Created by Brian Rogers on 2/24/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNMainController.h"

@interface RNFeedModel : NSObject

@property (retain) NSOperationQueue *queue;
@property (retain) NSArray *feeds;
@property (retain) NSString *text;
@property (retain) RNMainController *viewController;
@property NSUInteger maxEntries;

- (void)refresh;

@end
