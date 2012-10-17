//
//  AvatarStore+TestingExtensions.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/17/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "AvatarStore+TestingExtensions.h"

@implementation AvatarStore (TestingExtensions)

- (void)setData:(NSData *)data forLocation:(NSString *)location {
    [dataCache setObject:data forKey:location];
}

- (NSNotificationCenter *)notificationCenter {
    return notificationCenter;
}

@end