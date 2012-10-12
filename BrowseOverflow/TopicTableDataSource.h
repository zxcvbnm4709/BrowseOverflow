//
//  EmptyTableViewDataSource.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/12/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicTableDataSource : NSObject <UITableViewDataSource>

- (void)setTopics:(NSArray *)newTopics;

@end
