//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/7/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"
#import "QuestionBuilder.h"
#import "Topic.h"

@interface StackOverflowManager ()

- (void)tellDelegateAboutQuestionSearchError:(NSError *)underlyingError;

@end

@implementation StackOverflowManager

@synthesize delegate;
@synthesize communicator;
@synthesize questionBuilder;

- (void)setDelegate:(id<StackOverflowManagerDelegate>)newDelegate {
    if (newDelegate && ![newDelegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the deleagte protocol" userInfo:nil] raise];
    }
    delegate = newDelegate;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic {
    [communicator searchForQuestionsWithTag:[topic tag]];
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error {
    [self tellDelegateAboutQuestionSearchError:error];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation {
    NSError *error = nil;
    NSArray *questions = [questionBuilder questionsFromJSON:objectNotation error:&error];
    if (!questions) {
        [self tellDelegateAboutQuestionSearchError:error];
    } else {
        [delegate didReceiveQuestions:questions];
    }
}

#pragma mark Class Continuation
- (void)tellDelegateAboutQuestionSearchError:(NSError *)underlyingError {
    NSDictionary *errorInfo = nil;
    if (underlyingError) {
        errorInfo = [NSDictionary dictionaryWithObject:underlyingError forKey:NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerErrorDomain code:StackOverflowManagerErrorQuestionSearchCode userInfo:errorInfo];
    [delegate fetchingQuestionsFailedWithError:reportableError];
}

@end

NSString *StackOverflowManagerErrorDomain = @"StackOverflowManagerError";
