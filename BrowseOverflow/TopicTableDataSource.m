//
//  EmptyTableViewDataSource.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/12/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "TopicTableDataSource.h"
#import "Topic.h"

@interface TopicTableDataSource()

- (Topic *)topicForIndexPath:(NSIndexPath *)indexPath;

@end

NSString *topicCellReuseIdentifier = @"Topic";

@implementation TopicTableDataSource {
    NSArray *topics;
}

- (void)setTopics:(NSArray *)newTopics {
    topics = newTopics;
}

- (Topic *)topicForIndexPath:(NSIndexPath *)indexPath {
    return [topics objectAtIndex:[indexPath row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSParameterAssert(section == 0);
    return [topics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert([indexPath section] == 0);
    NSParameterAssert([indexPath row] < [topics count]);
    UITableViewCell *topicCell = [tableView dequeueReusableCellWithIdentifier:topicCellReuseIdentifier];
    if (!topicCell) {
        topicCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topicCellReuseIdentifier];
    }
    topicCell.textLabel.text = [[self topicForIndexPath:indexPath] name];
    return topicCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNotification *note = [NSNotification notificationWithName:TopicTableDidSelectTopicNotification object:[self topicForIndexPath:indexPath]];
    [[NSNotificationCenter defaultCenter] postNotification:note];
}

@end

NSString *TopicTableDidSelectTopicNotification = @"TopicTableDidSelectTopicNotification";
