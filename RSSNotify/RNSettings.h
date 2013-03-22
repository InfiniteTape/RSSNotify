//
//  RNSettings.h
//  RSSNotify
//
//  Created by Brian Rogers on 3/22/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RNSettings : NSObject

@property (strong, atomic) NSMutableArray *feedList;
@property NSUInteger refreshTime;
@property NSUInteger maxEntries;

-(void)load;
-(void)save;

@end
