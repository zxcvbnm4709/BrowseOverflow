//
//  FakeAnswerBuilder.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/9/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "AnswerBuilder.h"

@class Question;

@interface FakeAnswerBuilder : AnswerBuilder

@property NSString *receivedJSON;
@property Question *questionToFill;
@property NSError *error;
@property BOOL successful;

@end
