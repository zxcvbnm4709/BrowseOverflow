//
//  StackOverflowCommunicatorDelegate.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/11/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StackOverflowCommunicatorDelegate <NSObject>

- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;
- (void)fetchingQuestionBodyFailedWithError:(NSError *)error;
- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;
- (void)fetchingAnswersFailedWithError:(NSError *)error;
- (void)receivedAnswerListJSON:(NSString *)objectNotation;

@end
