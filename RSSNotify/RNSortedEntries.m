//
//  RNSortedEntries.m
//  RSSNotify
//
//  Created by Brian Rogers on 3/2/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "RNSortedEntries.h"


@implementation RNSortedEntries

- (id)init
{
    self = [super init];
    _entries = [[NSMutableArray alloc] init];
    _maxSize = 0;
    return self;
}

- (id)initWithMaxSize:(uint)maxSize
{
    self = [self init];
    _maxSize = maxSize;
    return self;
}

-(uint)getMaxSize
{
    return _maxSize;
}

- (void)purgeOldestEntry
{
    [_entries removeObjectAtIndex:([_entries count]-1)];
}

- (void)addEntry:(RNRSSEntry *)entry
{
    if(_entries.count > 0)
    {
        RNRSSEntry *newestEntry = [_entries objectAtIndex:0];
        if((![_entries containsObject:entry]) &&
           ((entry.articleDate > newestEntry.articleDate) ||
            (_entries.count < _maxSize)))
        {
            while(_entries.count >= _maxSize)
                [self purgeOldestEntry];
        
            int i;
            bool inserted = false;
            for(i = 0; i<_entries.count; i++)
            {
                RNRSSEntry *thisEntry = [_entries objectAtIndex:i];
                if((entry.articleDate >= thisEntry.articleDate) &&
                   (entry.articleTitle != thisEntry.articleTitle))
                {
                    [_entries insertObject:entry atIndex:i];
                    inserted = true;
                }
            }
            if(!inserted)
                [_entries addObject:entry];
        }
    }
    else [_entries addObject:entry];
}

- (RNRSSEntry *)getEntryAtIndex:(uint)index
{
    return (RNRSSEntry *)[_entries objectAtIndex:index];
}

@end

