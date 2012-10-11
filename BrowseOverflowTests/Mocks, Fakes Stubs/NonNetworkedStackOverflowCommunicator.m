//
//  NonNetworkedStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/11/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "NonNetworkedStackOverflowCommunicator.h"

@implementation NonNetworkedStackOverflowCommunicator

- (void)setReceivedData:(NSData *)data {
    receivedData = [data mutableCopy];
}

- (NSData *)receivedData {
    return [receivedData copy];
}

@end
