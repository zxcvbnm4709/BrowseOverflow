//
//  FakeURLResponse.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/11/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeURLResponse : NSObject {
    NSInteger statusCode;
}

- (id)initWithStatusCode:(NSInteger)code;
- (NSInteger)statusCode;

@end
