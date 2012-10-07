//
//  Question.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/6/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;

@interface Question : NSObject

@property NSDate *date;
@property NSString *title;
@property NSInteger score;
@property (readonly) NSArray *answers;

- (void)addAnswer:(Answer *)answer;

@end
