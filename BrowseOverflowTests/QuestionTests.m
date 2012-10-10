//
//  QuestionTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/6/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "QuestionTests.h"
#import "Question.h"
#import "Answer.h"
#import "Person.h"

@implementation QuestionTests {
    Question *question;
    Answer *lowScore;
    Answer *highScore;
    Person *asker;
}

- (void)setUp {
    question = [[Question alloc] init];
    question.date = [NSDate distantPast];
    question.title = @"Do iPhones also dream?";
    question.body = @"whatever";
    question.score = 42;
    question.questionID = 17;
    
    Answer *accepted = [[Answer alloc] init];
    accepted.score = 1;
    accepted.accepted = YES;
    [question addAnswer:accepted];
    
    lowScore = [[Answer alloc] init];
    lowScore.score = -4;
    [question addAnswer:lowScore];
    
    highScore = [[Answer alloc] init];
    highScore.score = 4;
    [question addAnswer:highScore];
    
    asker = [[Person alloc] initWithName:@"Graham Lee" avatarLocation:@"http://example.com/avatar.png"];
    question.asker = asker;
}

- (void)tearDown {
    question = nil;
    lowScore = nil;
    highScore = nil;
    asker = nil;
}

- (void)testQuestionHasATitle {
    STAssertEqualObjects(question.title, @"Do iPhones also dream?", @"Question should have a title");
}

- (void)testQuestionHasABody {
    STAssertEqualObjects(question.body, @"whatever", @"Question should have body content");
}

- (void)testQuestionHasDate {
    STAssertEqualObjects(question.date, [NSDate distantPast], @"Question needs to provide its date");
}

- (void)testQuestionHasIdentity {
    STAssertEquals(question.questionID, 17, @"Question needs a numeric identifier");
}

- (void)testQuestionsKeepScore {
    STAssertEquals(question.score, 42, @"Questions need a numeric score");
}

- (void)testQuestionCanHaveAnswersAdded {
    Answer *myAnswer = [[Answer alloc] init];
    STAssertNoThrow([question addAnswer:myAnswer], @"Must be able to add answers");
}

- (void)testAcceptedAnswerIsFirst {
    STAssertTrue([[question.answers objectAtIndex:0] isAccepted], @"Accepted answer comes first");
}

- (void)testHighScoreAnswerComesBeforeLow {
    NSArray *answers = question.answers;
    NSInteger highIndex = [answers indexOfObject:highScore];
    NSInteger lowIndex = [answers indexOfObject:lowScore];
    STAssertTrue(highIndex < lowIndex, @"High scoring answer comes first");
}

- (void)testQuestionWasAskedBySomeone {
    STAssertEqualObjects(question.asker, asker, @"Question should keep track of who asked it");
}

@end
