//
//  BrowseOverflowObjectConfiguration.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/17/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "BrowseOverflowObjectConfiguration.h"
#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"
#import "QuestionBuilder.h"
#import "AnswerBuilder.h"
#import "AvatarStore.h"

@implementation BrowseOverflowObjectConfiguration

- (StackOverflowManager *)stackOverflowManager {
    StackOverflowManager *manager = [[StackOverflowManager alloc] init];
    manager.communicator = [[StackOverflowCommunicator alloc] init];
    manager.communicator.delegate = manager;
    manager.questionBuilder = [[QuestionBuilder alloc] init];
    manager.answerBuilder = [[AnswerBuilder alloc] init];
    return manager;
}

- (AvatarStore *)avatarStore {
    static AvatarStore *avatarStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        avatarStore = [[AvatarStore alloc] init];
        [avatarStore useNotificationCenter:[NSNotificationCenter defaultCenter]];
    });
    return avatarStore;
}

@end
