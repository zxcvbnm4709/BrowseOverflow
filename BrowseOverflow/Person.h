//
//  Person.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/6/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (readonly, strong) NSString *name;
@property (readonly, strong) NSURL *avatarURL;

- (id)initWithName:(NSString *)aName avatarLocation:(NSString *)location;

@end
