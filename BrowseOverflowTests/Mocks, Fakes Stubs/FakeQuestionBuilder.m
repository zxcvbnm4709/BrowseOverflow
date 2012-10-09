//
//  FakeQuestionBuilder.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "FakeQuestionBuilder.h"
#import "Question.h"

@implementation FakeQuestionBuilder

@synthesize JSON;
@synthesize arrayToReturn;
@synthesize errorToSet;
@synthesize questionToFill;

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error {
    self.JSON = objectNotation;
    if (error) {
        *error = errorToSet;
    }
    return arrayToReturn;
}

- (void)fillInDetailsForQuestion:(Question *)question fromJSON:(NSString *)objectNotation {
    self.JSON = objectNotation;
    self.questionToFill = question;
}

@end
