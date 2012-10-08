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

- (void)fetchingQuestionsFailedWithError:(NSError *)error {
    self.fetchError = error;
}

- (void)didReceiveQuestions:(NSArray *)questions {
    self.fetchedQuestions = questions;
}

@end
