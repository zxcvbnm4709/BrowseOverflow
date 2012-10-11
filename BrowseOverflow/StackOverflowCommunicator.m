//
//  StackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface StackOverflowCommunicator()

- (void)fetchContentAtURL:(NSURL *)url;

@end

@implementation StackOverflowCommunicator

- (void)fetchContentAtURL:(NSURL *)url {
    fetchingURL = url;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fetchingURL];
    
    [fetchingConnection cancel];
    fetchingConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)searchForQuestionsWithTag:(NSString *)tag {
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackoverflow.com/1.1/search?tagged=%@&pagesize=20", tag]]];
}

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackoverflow.com/1.1/questions/%d?body=true", identifier]]];
}

- (void)downloadAnswersToQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackoverflow.com/1.1/questions/%d/answers?body=true", identifier]]];
}

- (void)cancelAndDiscardURLConnection {
    [fetchingConnection cancel];
    fetchingConnection = nil;
}

@end
