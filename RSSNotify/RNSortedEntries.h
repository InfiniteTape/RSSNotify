//
//  RNSortedEntries.h
//  RSSNotify
//
//  Created by Brian Rogers on 3/2/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNRSSEntry.h"

@interface RNSortedEntries : NSObject{
    uint _maxSize;
    NSMutableArray *_entries;
}

- (id)initWithMaxSize:(uint)maxSize;
- (uint)getMaxSize;
- (RNRSSEntry *)getEntryAtIndex:(uint)index;
- (void)addEntry:(RNRSSEntry *)entry;

@end




