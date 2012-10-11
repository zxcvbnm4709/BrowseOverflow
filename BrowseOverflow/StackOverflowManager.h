//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"
#import "StackOverflowCommunicatorDelegate.h"

@class StackOverflowCommunicator;
@class QuestionBuilder;
@class Topic;
@class Question;
@class AnswerBuilder;

@interface StackOverflowManager : NSObject <StackOverflowCommunicatorDelegate>

@property (weak, nonatomic) id<StackOverflowManagerDelegate> delegate;
@property StackOverflowCommunicator *communicator;
@property QuestionBuilder *questionBuilder;
@property AnswerBuilder *answerBuilder;
@property Question *questionNeedingBody;
@property Question *questionToFill;

- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)fetchBodyForQuestion:(Question *)question;
- (void)fetchAnswersForQuestion:(Question *)question;

@end

extern NSString *StackOverflowManagerErrorDomain;

enum {
    StackOverflowManagerErrorQuestionSearchCode,
    StackOverflowManagerErrorAnswerFetchCode
};