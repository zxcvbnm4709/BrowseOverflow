//
//  MockStackOverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"

@implementation MockStackOverflowManagerDelegate

@synthesize fetchError;
@synthesize fetchedQuestions;
@synthesize bodyQuestion;
@synthesize successQuestion;

- (void)fetchingQuestionsFailedWithError:(NSError *)error {
    self.fetchError = error;
}

- (void)didReceiveQuestions:(NSArray *)questions {
    self.fetchedQuestions = questions;
}

- (void)bodyReceivedForQuestion:(Question *)question {
    self.bodyQuestion = question;
}

- (void)retrievingAnswersFailedWithError:(NSError *)error {
    self.fetchError = error;
}

- (void)answersReceivedForQuestion:(Question *)question {
    self.successQuestion = question;
}

@end
