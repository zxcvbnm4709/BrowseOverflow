//
//  QuestionBuilderTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/8/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "QuestionBuilderTests.h"
#import "QuestionBuilder.h"
#import "Question.h"
#import "Person.h"

static NSString *questionJSON = @"{"
@"\"total\": 1,"
@"\"page\": 1,"
@"\"pagesize\": 30,"
@"\"questions\": ["
@"{"
@"\"tags\": ["
@"\"iphone\","
@"\"security\","
@"\"keychain\""
@"],"
@"\"answer_count\": 1,"
@"\"accepted_answer_id\": 3231900,"
@"\"favorite_count\": 1,"
@"\"question_timeline_url\": \"/questions/2817980/timeline\","
@"\"question_comments_url\": \"/questions/2817980/comments\","
@"\"question_answers_url\": \"/questions/2817980/answers\","
@"\"question_id\": 2817980,"
@"\"owner\": {"
@"\"user_id\": 23743,"
@"\"user_type\": \"registered\","
@"\"display_name\": \"Graham Lee\","
@"\"reputation\": 13459,"
@"\"email_hash\": \"563290c0c1b776a315b36e863b388a0c\""
@"},"
@"\"creation_date\": 1273660706,"
@"\"last_activity_date\": 1278965736,"
@"\"up_vote_count\": 2,"
@"\"down_vote_count\": 0,"
@"\"view_count\": 465,"
@"\"score\": 2,"
@"\"community_owned\": false,"
@"\"title\": \"Why does Keychain Services return the wrong keychain content?\","
@"\"body\": \"<p>I've been trying to use persistent keychain references.</p>\""
@"}"
@"]"
@"}";

static NSString *stringIsNotJSON = @"Not JSON";
static NSString *noQuestionsJSONString = @"{ \"noquestions\" : true }";
static NSString *emptyQuestionsArray = @"{ \"questions\" : [{}] }";

@implementation QuestionBuilderTests {
    QuestionBuilder *questionBuilder;
    Question *question;
}

- (void)setUp {
    questionBuilder = [[QuestionBuilder alloc] init];
    question = [[questionBuilder questionsFromJSON:questionJSON error:NULL] objectAtIndex:0];
}

- (void)tearDown {
    questionBuilder = nil;
    question = nil;
}

- (void)testThatNilIsNotAnAcceptableParameter {
    STAssertThrows([questionBuilder questionsFromJSON:nil error:NULL], @"Lack of data should have been handled elsewhere");
}

- (void)testNilReturnedWhenStringIsNotJSON {
    STAssertNil([questionBuilder questionsFromJSON:stringIsNotJSON error:NULL], @"This parameter should not be parsable");
}

- (void)testErrorSetWhenStringIsNotJSON {
    NSError *error = nil;
    [questionBuilder questionsFromJSON:stringIsNotJSON error:&error];
    STAssertNotNil(error, @"An error occurred, we should be told");
}

- (void)testPassingNullErrorDoesNotCauseCrash {
    STAssertNoThrow([questionBuilder questionsFromJSON:stringIsNotJSON error:NULL], @"Using a NULL error parameter should not be a problem");
}

- (void)testRealJSONWithoutQuestionsArrayIsError {
    STAssertNil([questionBuilder questionsFromJSON:noQuestionsJSONString error:NULL], @"No question to parse in this JSON");
}

- (void)testRealJSONWithoutQuestionReturnsMissingDataError {
    NSError *error = nil;
    [questionBuilder questionsFromJSON:noQuestionsJSONString error:&error];
    STAssertEquals([error code], QuestionBuilderErrorMissingDataCode, @"This case should not be an invalid JSON error");
}

- (void)testJSONWithOneQuestionReturnsOneQuestionObject {
    NSError *error = nil;
    NSArray *questions = [questionBuilder questionsFromJSON:questionJSON error:&error];
    STAssertEquals([questions count], (NSUInteger)1, @"The builder should have created a question");
}

- (void)testQuestionCreatedFromJSONHasPropertiesPresentedInJSON {
    STAssertEquals(question.questionID, 2817980, @"The question ID should match the data we sent");
    STAssertEquals([question.date timeIntervalSince1970], (NSTimeInterval)1273660706, @"The date of the question should match the data");
    STAssertEqualObjects(question.title, @"Why does Keychain Services return the wrong keychain content?", @"Title should match the provided data");
    STAssertEquals(question.score, 2, @"Score should match the data");
    Person *asker = question.asker;
    STAssertEqualObjects(asker.name, @"Graham Lee", @"Looks like I should have asked this question");
    STAssertEqualObjects([asker.avatarURL absoluteString], @"http://www.gravatar.com/avatar/563290c0c1b776a315b36e863b388a0c", @"The avatar URL should be based on the supplied email hash");
}

- (void)testQuestionCreatedFromEmptyObjectIsStillValidObject {
    NSArray *questions = [questionBuilder questionsFromJSON:emptyQuestionsArray error:NULL];
    STAssertEquals([questions count], (NSUInteger)1, @"QuestionBuilder must handle partial input");
}

@end
