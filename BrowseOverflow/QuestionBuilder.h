//
//  QuestionBuilder.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionBuilder : NSObject

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error;

@end

extern NSString *QuestionBuilderErrorDomain;

enum {
    QuestionBuilderErrorInvalidJSONCode,
    QuestionBuilderErrorMissingDataCode
};