//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"

@class StackOverflowCommunicator;
@class QuestionBuilder;
@class Topic;

@interface StackOverflowManager : NSObject

@property (weak, nonatomic) id<StackOverflowManagerDelegate> delegate;
@property StackOverflowCommunicator *communicator;
@property QuestionBuilder *questionBuilder;

- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;

@end
