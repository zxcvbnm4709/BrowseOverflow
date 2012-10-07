//
//  QuestionCreationTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "QuestionCreationTests.h"
#import "StackOverflowManager.h"
#import "MockStackOverflowManagerDelegate.h"
#import "MockStackOverflowCommunicator.h"
#import "Topic.h"
#import "FakeQuestionBuilder.h"

@implementation QuestionCreationTests {
    StackOverflowManager *mgr;
}

- (void)setUp {
    mgr = [[StackOverflowManager alloc] init];
}

- (void)tearDown {
    mgr = nil;
}

- (void)testNonConformingObjectCannotBeDelegate {
    STAssertThrows(mgr.delegate = (id <StackOverflowManagerDelegate>)[NSNull null], @"NSNull should not be used as the delegate as doesn't conform to the delegate protocol");
}

- (void)testConformingObjectCanBeDelegate {
    id <StackOverflowManagerDelegate> delegate = [[MockStackOverflowManagerDelegate alloc] init];
    STAssertNoThrow(mgr.delegate = delegate, @"Object conforming to the delegate protocol should be used as the delegate");
}

- (void)testManagerAcceptsNilAsDelegate {
    STAssertNoThrow(mgr.delegate = nil, @"It should be acceptable to use nil as an object's delegate");
}

- (void)testAskingForQuestionsMeansRequestingData {
    MockStackOverflowCommunicator *communicator = [[MockStackOverflowCommunicator alloc] init];
    mgr.communicator = communicator;
    Topic *topic = [[Topic alloc] initWithName:@"iPhone" tag:@"tag"];
    [mgr fetchQuestionsOnTopic:topic];
    STAssertTrue([communicator wasAskedToFetchQuestions], @"The communicator should need to fetch data.");
}

- (void)testErrorReturnedToDelegateIsNotErrorNotifiedByCommunicator {
    MockStackOverflowManagerDelegate *delegate = [[MockStackOverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    NSError *underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    STAssertFalse(underlyingError == [delegate fetchError], @"Error should be at the correct level of abstraction");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError {
    MockStackOverflowManagerDelegate *delegate = [[MockStackOverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    NSError *underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    STAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], underlyingError, @"The underlying error should be available to clinet code");
}

- (void)testQuestionJSONIsPassedToQuestionBuilder {
    FakeQuestionBuilder *builder = [[FakeQuestionBuilder alloc] init];
    mgr.questionBuilder = builder;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    STAssertEqualObjects(builder.JSON, @"Fake JSON", @"Downloaded JSON is sent to the builder");
    mgr.questionBuilder = nil;
}

@end
