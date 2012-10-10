//
//  AnswerBuilderTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/10/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "AnswerBuilderTests.h"
#import "AnswerBuilder.h"
#import "Question.h"
#import "Answer.h"
#import "Person.h"

static NSString *realAnswerJSON = @"{"
@"\"total\": 1,"
@"\"page\": 1,"
@"\"pagesize\": 30,"
@"\"answers\": ["
@"{"
@"\"answer_id\": 3231900,"
@"\"accepted\": true,"
@"\"answer_comments_url\": \"/answers/3231900/comments\","
@"\"question_id\": 2817980,"
@"\"owner\": {"
@"\"user_id\": 266380,"
@"\"user_type\": \"registered\","
@"\"display_name\": \"dmaclach\","
@"\"reputation\": 151,"
@"\"email_hash\": \"d96ae876eac0075727243a10fab823b3\""
@"},"
@"\"creation_date\": 1278965736,"
@"\"last_activity_date\": 1278965736,"
@"\"up_vote_count\": 1,"
@"\"down_vote_count\": 0,"
@"\"view_count\": 0,"
@"\"score\": 1,"
@"\"community_owned\": false,"
@"\"title\": \"Why does Keychain Services return the wrong keychain content?\","
@"\"body\": \"<p>Turns out that using the kSecMatchItemList doesn't appear to work at all. </p>\""
@"}"
@"]"
@"}";
static NSString *stringIsNotJSON = @"Not JSON";
static NSString *noAnswersJSONString = @"{ \"noanswers\": true }";

@implementation AnswerBuilderTests {
    AnswerBuilder *answerBuilder;
    Question *question;
}

- (void)setUp {
    answerBuilder = [[AnswerBuilder alloc] init];
    question = [[Question alloc] init];
    question.questionID = 12345;
}

- (void)testThatSendingNilJSONIsNotAnOption {
    STAssertThrows([answerBuilder addAnswersToQuestion:question fromJSON:nil error:NULL], @"Not having data should have already been handled");
}

- (void)testThatAddingAnswersToNilQuestionIsNotSupported {
    STAssertThrows([answerBuilder addAnswersToQuestion:nil fromJSON:stringIsNotJSON error:NULL], @"Makes no sense to have answers without a question");
}

- (void)testSendingNonJSONIsAnError {
    NSError *error = nil;
    STAssertFalse([answerBuilder addAnswersToQuestion:question fromJSON:stringIsNotJSON error:&error], @"Can't successfully create answers without real data");
    STAssertEqualObjects([error domain], AnswerBuilderErrorDomain, @"This should be an AnswerBuilder error");
}

- (void)testErrorParameterMayBeNULL {
    STAssertNoThrow([answerBuilder addAnswersToQuestion:question fromJSON:stringIsNotJSON error:NULL], @"AnswerBuilder should handle a NULL pointer gracefully");
}

- (void)testSendingWithIncorrectKeysIsAnError {
    NSError *error = nil;
    STAssertFalse([answerBuilder addAnswersToQuestion:question fromJSON:noAnswersJSONString error:&error], @"There must be a collection of answers in the input data");
}

- (void)testAddingRealAnswerJSONIsNotAnError {
    STAssertTrue([answerBuilder addAnswersToQuestion:question fromJSON:realAnswerJSON error:NULL], @"Should be ok to actually want to add answers");
}

- (void)testNumberOfAnswersAddedMatchNumberInData {
    [answerBuilder addAnswersToQuestion:question fromJSON:realAnswerJSON error:NULL];
    STAssertEquals([question.answers count], (NSUInteger)1, @"One answer added to zero should mean one answer");
}

- (void)testAnswerPropertiesMatchDataReceived {
    [answerBuilder addAnswersToQuestion:question fromJSON:realAnswerJSON error:NULL];
    Answer *answer = [question.answers objectAtIndex:0];
    STAssertEquals(answer.score, (NSInteger)1, @"Score property should be set from JSON");
    STAssertTrue(answer.accepted, @"Answer should be accepted as in JSON data");
    STAssertEqualObjects(answer.text, @"<p>Turns out that using the kSecMatchItemList doesn't appear to work at all. </p>", @"Answer body should match fed data");
}

- (void)testAnswerIsProvidedByExpectedPerson {
    [answerBuilder addAnswersToQuestion:question fromJSON:realAnswerJSON error:NULL];
    Answer *answer = [question.answers objectAtIndex:0];
    Person *answerer = answer.person;
    STAssertEqualObjects(answerer.name, @"dmaclach", @"The provided person name was used");
    STAssertEqualObjects([answerer.avatarURL absoluteString], @"http://www.gravatar.com/avatar/d96ae876eac0075727243a10fab823b3", @"The provided email hash was converted to an avatar URL");
}

@end
