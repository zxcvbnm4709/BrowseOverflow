//
//  NonNetworkedStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/11/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface NonNetworkedStackOverflowCommunicator : StackOverflowCommunicator

@property (copy) NSData *receivedData;

@end
