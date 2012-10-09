//
//  QuestionBuilder.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "QuestionBuilder.h"
#import "Question.h"
#import "Person.h"

@implementation QuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error {
    NSParameterAssert(objectNotation != nil);
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    NSDictionary *parsedObject = (id)jsonObject;
    if (parsedObject == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderErrorInvalidJSONCode userInfo:nil];
        }
        return nil;
    }
    NSArray *questions = [parsedObject objectForKey:@"questions"];
    if (questions == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderErrorMissingDataCode userInfo:nil];
        }
        return nil;
    }
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:[questions count]];
    for (NSDictionary *parsedQuestion in questions) {
        Question *thisQuestion = [[Question alloc] init];
        thisQuestion.questionID = [[parsedQuestion objectForKey:@"question_id"] integerValue];
        thisQuestion.date = [NSDate dateWithTimeIntervalSince1970:[[parsedQuestion objectForKey:@"creation_date"] doubleValue]];
        thisQuestion.title = [parsedQuestion objectForKey:@"title"];
        thisQuestion.score = [[parsedQuestion objectForKey:@"score"] integerValue];
        NSDictionary *ownerValues = [parsedQuestion objectForKey:@"owner"];
        thisQuestion.asker = [[Person alloc] initWithName:[ownerValues objectForKey:@"display_name"] avatarLocation:[NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@", [ownerValues objectForKey:@"email_hash"]]];
        [results addObject:thisQuestion];
    }
    return [results copy];
}

@end

NSString *QuestionBuilderErrorDomain = @"QuestionBuilderErrorDomain";