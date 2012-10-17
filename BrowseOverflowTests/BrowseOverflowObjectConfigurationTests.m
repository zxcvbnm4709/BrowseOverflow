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
#import "AvatarStore.h"
#import "AvatarStore+TestingExtensions.h"

@implementation BrowseOverflowObjectConfigurationTests {
    BrowseOverflowObjectConfiguration *configuration;
}

- (void)setUp {
    configuration = [[BrowseOverflowObjectConfiguration alloc] init];
}

- (void)tearDown {
    configuration = nil;
}

- (void)testConfigurationOfCreatedStackOverflowManager {
    StackOverflowManager *manager = [configuration stackOverflowManager];
    STAssertNotNil(manager, @"The StackOverflowManager should exist");
    STAssertNotNil(manager.communicator, @"Manager should have a StackOverflowCommunicator");
    STAssertNotNil(manager.questionBuilder, @"Manager should have a question builder");
    STAssertNotNil(manager.answerBuilder, @"Manager should ahve an answer builder");
    STAssertEqualObjects(manager.communicator.delegate, manager, @"The manager is the communicator's delegate");
}

- (void)testConfigurationOfCreatedAvatarStore {
    AvatarStore *store = [configuration avatarStore];
    STAssertEqualObjects([store notificationCenter], [NSNotificationCenter defaultCenter], @"Configured AvatarStore posts notifications to the default center");
}

- (void)testSameAvatarStoreAlwaysReturned {
    AvatarStore *store1 = [configuration avatarStore];
    AvatarStore *store2 = [configuration avatarStore];
    STAssertEqualObjects(store1, store2, @"The same store should always be used");
}

@end
