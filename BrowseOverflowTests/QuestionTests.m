//
//  QuestionTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/6/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "QuestionTests.h"
#import "Question.h"

@implementation QuestionTests {
    Question *question;
}

- (void)setUp {
    question = [[Question alloc] init];
    question.date = [NSDate distantPast];
    question.title = @"Do iPhones also dream?";
    question.score = 42;
}

- (void)tearDown {
    question = nil;
}

- (void)testQuestionHasDate {
    NSDate *testDate = [NSDate distantPast];
    question.date = testDate;
    STAssertEqualObjects(question.date, testDate, @"Question needs to provide its date");
}

- (void)testQuestionsKeepScore {
    STAssertEquals(question.score, 42, @"Questions need a numeric score");
}

- (void)testQuestionHasTitle {
    STAssertEqualObjects(question.title, @"Do iPhones also dream?", @"Question should have a title");
}

@end
