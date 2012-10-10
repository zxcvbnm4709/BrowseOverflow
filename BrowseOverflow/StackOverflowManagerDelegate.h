//
//  StackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Topic;
@class Question;

@protocol StackOverflowManagerDelegate <NSObject>

- (void)fetchingQuestionsFailedWithError:(NSError *)error;
- (void)didReceiveQuestions:(NSArray *)questions;
- (void)bodyReceivedForQuestion:(Question *)question;
- (void)retrievingAnswersFailedWithError:(NSError *)error;
- (void)answersReceivedForQuestion:(Question *)question;

@end
