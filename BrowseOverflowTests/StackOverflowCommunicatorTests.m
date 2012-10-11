//
//  StackOverflowCommunicatorTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/11/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "StackOverflowCommunicatorTests.h"
#import "InspectableStackOverflowCommunicator.h"
#import "NonNetworkedStackOverflowCommunicator.h"
#import "MockStackOverflowManager.h"
#import "FakeURLResponse.h"

@implementation StackOverflowCommunicatorTests {
    InspectableStackOverflowCommunicator *communicator;
    NonNetworkedStackOverflowCommunicator *nnCommunicator;
    MockStackOverflowManager *manager;
    FakeURLResponse *fourOhFourResponse;
    NSData *receivedData;
}

- (void)setUp {
    communicator = [[InspectableStackOverflowCommunicator alloc] init];
    nnCommunicator = [[NonNetworkedStackOverflowCommunicator alloc] init];
    manager = [[MockStackOverflowManager alloc] init];
    nnCommunicator.delegate = manager;
    fourOhFourResponse = [[FakeURLResponse alloc] initWithStatusCode:404];
    receivedData = [@"Result" dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)tearDown {
    [communicator cancelAndDiscardURLConnection];
    communicator = nil;
    nnCommunicator = nil;
    manager = nil;
    fourOhFourResponse = nil;
    receivedData = nil;
}

- (void)testSearchingForQuestionsOnTopicCallsTopicAPI {
    [communicator searchForQuestionsWithTag:@"ios"];
    STAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/search?tagged=ios&pagesize=20", @"Use the search API to find question with a particular tag");
}

- (void)testFillingInQuestionBodyCallsQuestionAPI {
    [communicator downloadInformationForQuestionWithID:12345];
    STAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/questions/12345?body=true", @"User the question API to get the body for a question");
}

- (void)testFetchingAnswersToQuestionCallsQuestionAPI {
    [communicator downloadAnswersToQuestionWithID:12345];
    STAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/questions/12345/answers?body=true", @"Use the question API to get answers on a given question");
}

- (void)testSearchingForQuestionsCreatesURLConnection {
    [communicator searchForQuestionsWithTag:@"ios"];
    STAssertNotNil([communicator currentURLConnection], @"There should be a URL connection in-flight now.");
    [communicator cancelAndDiscardURLConnection];
}

- (void)testStartingNewSearchThrowsOutOldConnection {
    [communicator searchForQuestionsWithTag:@"ios"];
    NSURLConnection *firstConnection = [communicator currentURLConnection];
    [communicator searchForQuestionsWithTag:@"cocoa"];
    STAssertFalse([[communicator currentURLConnection] isEqual:firstConnection], @"The communicator needs to replace its URL connection to start a new one");
    [communicator cancelAndDiscardURLConnection];
}

- (void)testReceivingResponseDiscardsExistingData {
    nnCommunicator.receivedData = [@"Hello" dataUsingEncoding:NSUTF8StringEncoding];
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    [nnCommunicator connection:nil didReceiveResponse:nil];
    STAssertEquals([nnCommunicator.receivedData length], (NSUInteger)0, @"Data should have been discarded");
}

- (void)testReceivingResponseWith404StatusPassesErrorToDelegate {
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    [nnCommunicator connection:nil didReceiveResponse:(NSURLResponse *)fourOhFourResponse];
    STAssertEquals([manager topicFailureErrorCode], 404, @"Fetch failure was passed through to delegate");
}

- (void)testNoErrorReceivedOn200Status {
    FakeURLResponse *twoHundredResponse = [[FakeURLResponse alloc] initWithStatusCode:200];
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    [nnCommunicator connection:nil didReceiveResponse:(NSURLResponse *)twoHundredResponse];
    STAssertFalse([manager topicFailureErrorCode] == 200, @"No need for error code on 200 response");
}

- (void)testConnectionFailingPassesErrorToDelegate {
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    NSError *error = [NSError errorWithDomain:@"Fake domain" code:12345 userInfo:nil];
    [nnCommunicator connection:nil didFailWithError:error];
    STAssertEquals([manager topicFailureErrorCode], 12345, @"Failure to connect should get passed to the delegate");
}

- (void)testSuccessfulQuestionSearchPassesDataToDelegate {
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    [nnCommunicator setReceivedData:receivedData];
    [nnCommunicator connectionDidFinishLoading:nil];
    STAssertEqualObjects([manager topicSearchString], @"Result", @"The delegate should have received data on success");
}

@end
