//
//  BrowseOverflowObjectConfigurationTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/17/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "BrowseOverflowObjectConfigurationTests.h"
#import "BrowseOverflowObjectConfiguration.h"
#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"

@implementation BrowseOverflowObjectConfigurationTests

- (void)testConfigurationOfCreatedStackOverflowManager {
    BrowseOverflowObjectConfiguration *configuration = [[BrowseOverflowObjectConfiguration alloc] init];
    StackOverflowManager *manager = [configuration stackOverflowManager];
    STAssertNotNil(manager, @"The StackOverflowManager should exist");
    STAssertNotNil(manager.communicator, @"Manager should have a StackOverflowCommunicator");
    STAssertNotNil(manager.questionBuilder, @"Manager should have a question builder");
    STAssertNotNil(manager.answerBuilder, @"Manager should ahve an answer builder");
    STAssertEqualObjects(manager.communicator.delegate, manager, @"The manager is the communicator's delegate");
}

@end
