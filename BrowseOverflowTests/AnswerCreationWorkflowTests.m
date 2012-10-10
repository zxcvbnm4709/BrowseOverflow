//
//  AnswerCreationWorkflowTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/9/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "AnswerCreationWorkflowTests.h"
#import "StackOverflowManager.h"
#import "MockStackOverflowCommunicator.h"
#import "MockStackOverflowManagerDelegate.h"
#import "Question.h"
#import "FakeAnswerBuilder.h"

static NSString *fakeJSON = @"Fake JSON";

@implementation AnswerCreationWorkflowTests {
    StackOverflowManager *manager;
    MockStackOverflowCommunicator *communicator;
    MockStackOverflowManagerDelegate *delegate;
    Question *question;
    FakeAnswerBuilder *answerBuilder;
    NSError *error;
}

- (void)setUp {
    manager = [[StackOverflowManager alloc] init];
    communicator = [[MockStackOverflowCommunicator alloc] init];
    manager.communicator = communicator;
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    manager.delegate = delegate;
    question = [[Question alloc] init];
    question.questionID = 12345;
    answerBuilder = [[FakeAnswerBuilder alloc] init];
    manager.answerBuilder = answerBuilder;
    error = [NSError errorWithDomain:@"Fake Domain" code:42 userInfo:nil];
}

- (void)testAskingForAnswersMeansCommunicatingWithSite {
    [manager fetchAnswersForQuestion:question];
    STAssertEquals(question.questionID, [communicator askedForAnswersToQuestionID], @"Answers to questions are found by communicating with the web site");
}

- (void)testDelegateNotifiedOfFailureToGetAnswers {
    [manager fetchingAnswersFailedWithError:error];
    STAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], error, @"Delegate should be notified of failure to communicate");
}

- (void)testManagerRemembersWhichQuestionToAddAnswersTo {
    [manager fetchAnswersForQuestion:question];
    STAssertEqualObjects(manager.questionToFill, question, @"Manager should know to fill this question in");
}

- (void)testAnswerResponsePassedToAnswerBuilder {
    [manager receivedAnswerListJSON:fakeJSON];
    STAssertEqualObjects([answerBuilder receivedJSON], fakeJSON, @"Manager must pass response to builder to get answers constructed");
}

- (void)testQuestionPassedToAnswerBuilder {
    manager.questionToFill = question;
    [manager receivedAnswerListJSON:fakeJSON];
    STAssertEqualObjects(answerBuilder.questionToFill, question, @"Manager must pass the question into the answer builder");
}

- (void)testManagerNotifiesDelegateWhenAnswersAdded {
    answerBuilder.successful = YES;
    manager.questionToFill = question;
    [manager receivedAnswerListJSON:fakeJSON];
    STAssertEqualObjects(delegate.successQuestion, question, @"Manager should call the delegate method");
}

- (void)testManagerNotifiesDelegateWhenAnswersNotAdded {
    answerBuilder.successful = NO;
    answerBuilder.error = error;
    [manager receivedAnswerListJSON:fakeJSON];
    STAssertEqualObjects([[delegate.fetchError userInfo] objectForKey:NSUnderlyingErrorKey], error, @"Manager should pass an error on to the delegate");
}

@end
