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
@class Question;

@interface StackOverflowManager : NSObject

@property (weak, nonatomic) id<StackOverflowManagerDelegate> delegate;
@property StackOverflowCommunicator *communicator;
@property QuestionBuilder *questionBuilder;
@property Question *questionNeedingBody;

- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;
- (void)fetchBodyForQuestion:(Question *)question;
- (void)fetchingQuestionBodyFailedWithError:(NSError *)error;
- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;

@end

extern NSString *StackOverflowManagerErrorDomain;

enum {
    StackOverflowManagerErrorQuestionSearchCode
};