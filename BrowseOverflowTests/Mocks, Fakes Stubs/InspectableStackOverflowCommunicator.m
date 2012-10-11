//
//  InspectableStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/11/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "InspectableStackOverflowCommunicator.h"

@implementation InspectableStackOverflowCommunicator

- (NSURL *)URLToFetch {
    return fetchingURL;
}

- (NSURLConnection *)currentURLConnection {
    return fetchingConnection;
}

@end
