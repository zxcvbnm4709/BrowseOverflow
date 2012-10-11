//
//  StackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverflowCommunicator : NSObject {
@protected
    NSURL *fetchingURL;
    NSURLConnection *fetchingConnection;
}

- (void)searchForQuestionsWithTag:(NSString *)tag;
- (void)downloadInformationForQuestionWithID:(NSInteger)identifier;
- (void)downloadAnswersToQuestionWithID:(NSInteger)identifier;

- (void)cancelAndDiscardURLConnection;

@end
