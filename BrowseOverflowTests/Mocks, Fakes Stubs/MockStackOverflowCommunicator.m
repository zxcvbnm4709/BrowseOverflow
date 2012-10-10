//
//  MockStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"

@implementation MockStackOverflowCommunicator {
    BOOL wasAskedToFetchQuestions;
    BOOL wasAskedToFetchBody;
    NSInteger questionID;
}

- (void)searchForQuestionsWithTag:(NSString *)tag {
    wasAskedToFetchQuestions = YES;
}

- (BOOL)wasAskedToFetchQuestions {
    return wasAskedToFetchQuestions;
}

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier {
    wasAskedToFetchBody = YES;
}

- (BOOL)wasAskedToFetchBody {
    return wasAskedToFetchBody;
}

- (void)downloadAnswersToQuestionWithID:(NSInteger)identifier {
    questionID = identifier;
}

- (NSInteger)askedForAnswersToQuestionID {
    return questionID;
}

@end
