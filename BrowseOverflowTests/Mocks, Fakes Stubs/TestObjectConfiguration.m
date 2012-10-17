//
//  TestObjectConfiguration.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/17/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "TestObjectConfiguration.h"

@implementation TestObjectConfiguration

@synthesize objectToReturn;

- (StackOverflowManager *)stackOverflowManager {
    return (StackOverflowManager *)self.objectToReturn;
}

@end
