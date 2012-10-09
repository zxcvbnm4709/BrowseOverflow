//
//  QuestionBuilderTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/8/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "QuestionBuilderTests.h"
#import "QuestionBuilder.h"

@implementation QuestionBuilderTests {
    QuestionBuilder *questionBuilder;
}

- (void)setUp {
    questionBuilder = [[QuestionBuilder alloc] init];
}

- (void)tearDown {
    questionBuilder = nil;
}

- (void)testThatNilIsNotAnAcceptableParameter {
    STAssertThrows([questionBuilder questionsFromJSON:nil error:NULL], @"Lack of data should have been handled elsewhere");
}

- (void)testNilReturnedWhenStringIsNotJSON {
    STAssertNil([questionBuilder questionsFromJSON:@"Not JSON" error:NULL], @"This parameter should not be parsable");
}

- (void)testErrorSetWhenStringIsNotJSON {
    NSError *error = nil;
    [questionBuilder questionsFromJSON:@"Not JSON" error:&error];
    STAssertNotNil(error, @"An error occurred, we should be told");
}

- (void)testPassingNullErrorDoesNotCauseCrash {
    STAssertNoThrow([questionBuilder questionsFromJSON:@"Not JSON" error:NULL], @"Using a NULL error parameter should not be a problem");
}

- (void)testRealJSONWithoutQuestionsArrayIsError {
    NSString *jsonString = @"{\"noquestions\":true}";
    STAssertNil([questionBuilder questionsFromJSON:jsonString error:NULL], @"No question to parse in this JSON");
}

- (void)testRealJSONWithoutQuestionReturnsMissingDataError {
    NSString *jsonString = @"{\"noquestions\":true}";
    NSError *error = nil;
    [questionBuilder questionsFromJSON:jsonString error:&error];
    STAssertEquals([error code], QuestionBuilderErrorMissingDataCode, @"This case should not be an invalid JSON error");
}

@end
