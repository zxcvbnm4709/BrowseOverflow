//
//  Answer.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;

@interface Answer : NSObject

@property (strong) NSString *text;
@property (strong) Person *person;
@property (getter=isAccepted) BOOL accepted;
@property NSInteger score;

@end
