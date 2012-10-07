//
//  AnswerTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "AnswerTests.h"
#import "Answer.h"
#import "Person.h"

@implementation AnswerTests {
    Answer *answer;
}

- (void)setUp {
    answer = [[Answer alloc] init];
    answer.text = @"The answer is 42";
    answer.person = [[Person alloc] initWithName:@"Graham" avatarLocation:@"http://example.com/avatar.png"];
    answer.score = 42;
}

- (void)tearDown {
    answer = nil;
}

- (void)testAnswerHasSomeText {
    STAssertEqualObjects(answer.text, @"The answer is 42", @"Answers need to contain some text");
}

- (void)testSomeoneProvidedTheAnswer {
    STAssertTrue([answer.person isKindOfClass:[Person class]], @"A Person gave this answer");
}

- (void)testAnswersNotAcceptedByDefault {
    STAssertFalse(answer.accepted, @"Answer not accepted by default");
}

- (void)testAnswerCanBeAccepted {
    STAssertNoThrow(answer.accepted = YES, @"It is possible to accept an answer");
}

- (void)testAnswerHasAScore {
    STAssertTrue(answer.score == 42, @"Answer's score can be retrieved");
}

@end
