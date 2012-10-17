//
//  BrowseOverflowObjectConfiguration.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/17/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StackOverflowManager;
@class AvatarStore;

@interface BrowseOverflowObjectConfiguration : NSObject

- (StackOverflowManager *)stackOverflowManager;
- (AvatarStore *)avatarStore;

@end
