//
//  MockStackOverflowManager.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/11/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicatorDelegate.h"

@class Topic;
@class Question;

@interface MockStackOverflowManager : NSObject <StackOverflowCommunicatorDelegate> {
    NSInteger topicFailureErrorCode;
    NSInteger bodyFailureErrorCode;
    NSInteger answerFailureErrorCode;
    NSString *topicSearchString;
    NSString *questionBodyString;
    NSString *answerListString;
    BOOL wasAskedToFetchQuestions;
    BOOL wasAskedToFetchAnswers;
    BOOL wasAskedToFetchBody;
}

- (NSInteger)topicFailureErrorCode;
- (NSInteger)bodyFailureErrorCode;
- (NSInteger)answerFailureErrorCode;

- (NSString *)topicSearchString;
- (NSString *)questionBodyString;
- (NSString *)answerListString;

- (BOOL)didFetchQuestions;
- (BOOL)didFetchAnswers;
- (BOOL)didFetchQuestionBody;
- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)fetchAnswersForQuestion:(Question *)question;
- (void)fetchBodyForQuestion:(Question *)question;

@property (strong) id delegate;

@end
