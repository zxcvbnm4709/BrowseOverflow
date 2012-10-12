//
//  EmptyTableViewDelegate.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/12/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "TopicTableDelegate.h"
#import "TopicTableDataSource.h"

@implementation TopicTableDelegate

@synthesize tableDataSource;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNotification *note = [NSNotification notificationWithName:TopicTableDidSelectTopicNotification object:[tableDataSource topicForIndexPath:indexPath]];
    [[NSNotificationCenter defaultCenter] postNotification:note];
}

@end

NSString *TopicTableDidSelectTopicNotification = @"TopicTableDidSelectTopicNotification";