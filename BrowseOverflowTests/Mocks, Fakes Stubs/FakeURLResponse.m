//
//  FakeURLResponse.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/11/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "FakeURLResponse.h"

@implementation FakeURLResponse

- (id)initWithStatusCode:(NSInteger)code {
    if (self = [super init]) {
        statusCode = code;
    }
    return self;
}

- (NSInteger)statusCode {
    return statusCode;
}

@end
