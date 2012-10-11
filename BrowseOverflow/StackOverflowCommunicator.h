//
//  StackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicatorDelegate.h"

@interface StackOverflowCommunicator : NSObject <NSURLConnectionDataDelegate> {
@protected
    NSURL *fetchingURL;
    NSURLConnection *fetchingConnection;
    NSMutableData *receivedData;
@private
    __weak id <StackOverflowCommunicatorDelegate> delegate;
    void (^errorHandler)(NSError *);
    void (^successHandler)(NSString *);
}

@property (weak) id <StackOverflowCommunicatorDelegate> delegate;

- (void)searchForQuestionsWithTag:(NSString *)tag;
- (void)downloadInformationForQuestionWithID:(NSInteger)identifier;
- (void)downloadAnswersToQuestionWithID:(NSInteger)identifier;

- (void)cancelAndDiscardURLConnection;

@end

extern NSString *StackOverflowCommunicatorErrorDomain;