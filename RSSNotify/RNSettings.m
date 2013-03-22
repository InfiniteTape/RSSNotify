//
//  RNSettings.m
//  RSSNotify
//
//  Created by Brian Rogers on 3/22/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "RNSettings.h"

@implementation RNSettings

- (id)init
{
    self = [super init];
    if (self) {
        _feedList = [[NSMutableArray alloc] init];
        _refreshTime = 5;
        _maxEntries = 5;
    }
    return self;
}

-(void)load {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs objectForKey:@"feedList"]) {
        _feedList = [prefs objectForKey:@"feedList"];
        _refreshTime = [prefs integerForKey:@"refreshTime"];
        _maxEntries = [prefs integerForKey:@"maxEntries"];
    }
    else {
        [self save];
    }
}

-(void)save {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:_feedList forKey:@"feedList"];
    [prefs setInteger:_refreshTime forKey:@"refreshTime"];
    [prefs setInteger:_maxEntries forKey:@"maxEntries"];
    [prefs synchronize];
}

@end
