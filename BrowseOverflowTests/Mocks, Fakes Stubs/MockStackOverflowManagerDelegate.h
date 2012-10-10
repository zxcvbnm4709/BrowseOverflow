//
//  MockStackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"

@interface MockStackOverflowManagerDelegate : NSObject <StackOverflowManagerDelegate>

@property NSError *fetchError;
@property NSArray *fetchedQuestions;
@property Question *bodyQuestion;
@property Question *successQuestion;

@end
