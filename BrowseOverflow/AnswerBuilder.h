//
//  AnswerBuilder.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/9/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@interface AnswerBuilder : NSObject

- (BOOL)addAnswersToQuestion:(Question *)question fromJSON:(NSString *)objectNotation error:(NSError **)addError;

@end

extern NSString *AnswerBuilderErrorDomain;

enum {
    AnswerBuilderErrorInvalidJSONCode,
    AnswerBuilderErrorMissingDataCode
};