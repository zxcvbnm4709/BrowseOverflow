//
//  AvatarStore+TestingExtensions.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/17/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "AvatarStore.h"

@interface AvatarStore (TestingExtensions)

- (void)setData:(NSData *)data forLocation:(NSString *)location;
- (NSNotificationCenter *)notificationCenter;

@end
