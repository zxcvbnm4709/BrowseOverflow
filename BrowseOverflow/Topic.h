//
//  Topic.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/5/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@interface Topic : NSObject

@property (readonly, strong) NSString *name;
@property (readonly, strong) NSString *tag;

- (id)initWithName:(NSString *)newName tag:(NSString *)newTag;
- (NSArray *)recentQuestions;
- (void)addQuestion:(Question *)question;

@end
