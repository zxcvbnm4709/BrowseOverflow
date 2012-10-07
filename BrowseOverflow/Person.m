//
//  Person.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/6/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize name;
@synthesize avatarURL;

- (id)initWithName:(NSString *)aName avatarLocation:(NSString *)location {
    if (self = [super init]) {
        name = [aName copy];
        avatarURL = [[NSURL alloc] initWithString:location];
    }
    return self;
}

@end
