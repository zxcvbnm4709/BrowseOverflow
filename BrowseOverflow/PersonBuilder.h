//
//  PersonBuilder.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/9/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;

@interface PersonBuilder : NSObject

+ (Person *)personFromDictionary:(NSDictionary *)ownerValues;

@end
