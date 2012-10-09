//
//  Question.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/6/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;
@class Person;

@interface Question : NSObject

@property NSDate *date;
@property NSString *title;
@property NSInteger score;
@property (readonly) NSArray *answers;
@property NSInteger questionID;
@property Person *asker;

- (void)addAnswer:(Answer *)answer;

@end
