//
//  StackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface StackOverflowCommunicator()

- (void)fetchContentAtURL:(NSURL *)url
             errorHandler:(void (^)(NSError *))errorBlcok
           successHandler:(void (^)(NSString *))successBlock;
- (void)launchConnectionForRequest:(NSURLRequest *)request;

@end

@implementation StackOverflowCommunicator

@synthesize delegate;

- (void)fetchContentAtURL:(NSURL *)url
             errorHandler:(void (^)(NSError *))errorBlcok
           successHandler:(void (^)(NSString *))successBlock {
    fetchingURL = url;
    errorHandler = [errorBlcok copy];
    successHandler = [successBlock copy];
    NSURLRequest *request = [NSURLRequest requestWithURL:fetchingURL];
    
    [self launchConnectionForRequest:request];
}

- (void)launchConnectionForRequest:(NSURLRequest *)request {
    [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)searchForQuestionsWithTag:(NSString *)tag {
    [self fetchContentAtURL:[NSURL URLWithString:
                             [NSString stringWithFormat:
                              @"http://api.stackoverflow.com/1.1/search?tagged=%@&pagesize=20", tag]]
               errorHandler:^(NSError *error) {
                   [delegate searchingForQuestionsFailedWithError:error];
               }
             successHandler:^(NSString *objectNotation) {
                 [delegate receivedQuestionsJSON:objectNotation];
             }];
}

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL:[NSURL URLWithString:
                             [NSString stringWithFormat:
                              @"http://api.stackoverflow.com/1.1/questions/%d?body=true", identifier]]
               errorHandler:^(NSError *error) {
                   [delegate fetchingQuestionBodyFailedWithError:error];
               }
             successHandler:^(NSString *objectNotation) {
                 [delegate receivedQuestionBodyJSON:objectNotation];
             }];
}

- (void)downloadAnswersToQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL:[NSURL URLWithString:
                             [NSString stringWithFormat:
                              @"http://api.stackoverflow.com/1.1/questions/%d/answers?body=true", identifier]]
               errorHandler:^(NSError *error) {
                   [delegate fetchingAnswersFailedWithError:error];
               }
             successHandler:^(NSString *objectNotation) {
                 [delegate receivedAnswerListJSON:objectNotation];
             }];
}

- (void)cancelAndDiscardURLConnection {
    [fetchingConnection cancel];
    fetchingConnection = nil;
}

#pragma mark NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    receivedData = nil;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ([httpResponse statusCode] != 200) {
        NSError *error = [NSError errorWithDomain:StackOverflowCommunicatorErrorDomain code:[httpResponse statusCode] userInfo:nil];
        errorHandler(error);
        [self cancelAndDiscardURLConnection];
    } else {
        receivedData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    receivedData = nil;
    fetchingConnection = nil;
    fetchingURL = nil;
    errorHandler(error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    fetchingConnection = nil;
    fetchingURL = nil;
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    receivedData = nil;
    successHandler(receivedText);
}

- (void)dealloc {
    [fetchingConnection cancel];
}

@end

NSString *StackOverflowCommunicatorErrorDomain = @"StackOverflowCommunicatorErrorDomain";