//
//  AnswerBuilder.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/9/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "AnswerBuilder.h"
#import "Question.h"
#import "Answer.h"
#import "PersonBuilder.h"

@implementation AnswerBuilder

- (BOOL)addAnswersToQuestion:(Question *)question fromJSON:(NSString *)objectNotation error:(NSError **)addError {
    NSParameterAssert(objectNotation != nil);
    NSParameterAssert(question != nil);
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError = nil;
    NSDictionary *answerData = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    if (answerData == nil) {
        if (addError) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
            if (localError != nil) {
                [userInfo setObject:localError forKey:NSUnderlyingErrorKey];
            }
            *addError = [NSError errorWithDomain:AnswerBuilderErrorDomain code:AnswerBuilderErrorInvalidJSONCode userInfo:userInfo];
        }
        return NO;
    }
    NSArray *answers = [answerData objectForKey:@"answers"];
    if (answers == nil) {
        if (addError) {
            *addError = [NSError errorWithDomain:AnswerBuilderErrorDomain code:AnswerBuilderErrorMissingDataCode userInfo:nil];
        }
        return NO;
    }
    
    for (NSDictionary *answerData in answers) {
        Answer *thisAnswer = [[Answer alloc] init];
        thisAnswer.text = [answerData objectForKey:@"body"];
        thisAnswer.accepted = [[answerData objectForKey:@"accepted"] boolValue];
        thisAnswer.score = [[answerData objectForKey:@"score"] integerValue];
        NSDictionary *ownerData = [answerData objectForKey:@"owner"];
        thisAnswer.person = [PersonBuilder personFromDictionary:ownerData];
        [question addAnswer:thisAnswer];
    }
    return YES;
}

@end

NSString *AnswerBuilderErrorDomain = @"AnswerBuilderErrorDomain";