//
//  Question.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/6/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "Question.h"
#import "Answer.h"

@implementation Question {
    NSMutableSet *answerSet;
}

@synthesize date;
@synthesize title;
@synthesize score;
@synthesize questionID;
@synthesize asker;
@synthesize body;

- (id)init {
    if (self = [super init]) {
        answerSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)addAnswer:(Answer *)answer {
    [answerSet addObject:answer];
}

- (NSArray *)answers {
    return [[answerSet allObjects] sortedArrayUsingSelector:@selector(compare:)];
}

@end
