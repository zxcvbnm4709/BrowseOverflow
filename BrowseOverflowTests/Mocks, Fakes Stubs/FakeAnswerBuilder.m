//
//  FakeAnswerBuilder.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/9/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "FakeAnswerBuilder.h"

@implementation FakeAnswerBuilder

@synthesize receivedJSON;
@synthesize questionToFill;
@synthesize error;
@synthesize successful;

- (BOOL)addAnswersToQuestion:(Question *)question fromJSON:(NSString *)objectNotation error:(NSError **)addError {
    self.receivedJSON = objectNotation;
    self.questionToFill = question;
    if (addError) {
        *addError = error;
    }
    return successful;
}

@end
