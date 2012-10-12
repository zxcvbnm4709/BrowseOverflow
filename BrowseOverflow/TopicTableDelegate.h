//
//  EmptyTableViewDelegate.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/12/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TopicTableDataSource;

@interface TopicTableDelegate : NSObject <UITableViewDelegate>

@property (strong) TopicTableDataSource *tableDataSource;

@end
