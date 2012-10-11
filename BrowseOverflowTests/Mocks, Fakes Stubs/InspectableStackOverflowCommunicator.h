//
//  InspectableStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/11/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface InspectableStackOverflowCommunicator : StackOverflowCommunicator

- (NSURL *)URLToFetch;
- (NSURLConnection *)currentURLConnection;

@end
