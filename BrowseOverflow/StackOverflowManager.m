//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"
#import "QuestionBuilder.h"
#import "AnswerBuilder.h"
#import "Topic.h"
#import "Question.h"

@interface StackOverflowManager ()

- (void)tellDelegateAboutQuestionSearchError:(NSError *)underlyingError;

@end

@implementation StackOverflowManager

@synthesize delegate;
@synthesize communicator;
@synthesize questionBuilder;
@synthesize questionNeedingBody;
@synthesize answerBuilder;
@synthesize questionToFill;

- (void)setDelegate:(id<StackOverflowManagerDelegate>)newDelegate {
    if (newDelegate && ![newDelegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the deleagte protocol" userInfo:nil] raise];
    }
    delegate = newDelegate;
}

#pragma mark Questions

- (void)fetchQuestionsOnTopic:(Topic *)topic {
    [communicator searchForQuestionsWithTag:[topic tag]];
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error {
    [self tellDelegateAboutQuestionSearchError:error];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation {
    NSError *error = nil;
    NSArray *questions = [questionBuilder questionsFromJSON:objectNotation error:&error];
    if (!questions) {
        [self tellDelegateAboutQuestionSearchError:error];
    } else {
        [delegate didReceiveQuestions:questions];
    }
}

- (void)fetchBodyForQuestion:(Question *)question {
    self.questionNeedingBody = question;
    [communicator downloadInformationForQuestionWithID:question.questionID];
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error {
    [self tellDelegateAboutQuestionSearchError:error];
}

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation {
    [questionBuilder fillInDetailsForQuestion:self.questionNeedingBody fromJSON:objectNotation];
    [delegate bodyReceivedForQuestion:self.questionNeedingBody];
}

#pragma mark Answers

- (void)fetchAnswersForQuestion:(Question *)question {
    self.questionToFill = question;
    [communicator downloadAnswersToQuestionWithID:question.questionID];
}

- (void)fetchingAnswersFailedWithError:(NSError *)error {
    self.questionToFill = nil;
    NSDictionary *userInfo = nil;
    if (error) {
        userInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerErrorDomain code:StackOverflowManagerErrorAnswerFetchCode userInfo:userInfo];
    [delegate retrievingAnswersFailedWithError:reportableError];
}

- (void)receivedAnswerListJSON:(NSString *)objectNotation {
    NSError *error = nil;
    if ([self.answerBuilder addAnswersToQuestion:self.questionToFill fromJSON:objectNotation error:&error]) {
        [delegate answersReceivedForQuestion:self.questionToFill];
        self.questionToFill = nil;
    } else {
        [self fetchingAnswersFailedWithError:error];
    }
}

#pragma mark Class Continuation
- (void)tellDelegateAboutQuestionSearchError:(NSError *)underlyingError {
    NSDictionary *errorInfo = nil;
    if (underlyingError) {
        errorInfo = [NSDictionary dictionaryWithObject:underlyingError forKey:NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerErrorDomain code:StackOverflowManagerErrorQuestionSearchCode userInfo:errorInfo];
    [delegate fetchingQuestionsFailedWithError:reportableError];
}

@end

NSString *StackOverflowManagerErrorDomain = @"StackOverflowManagerError";
