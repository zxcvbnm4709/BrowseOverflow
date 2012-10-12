//
//  EmptyTableViewDataSource.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/12/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "TopicTableDataSource.h"
#import "Topic.h"

NSString *topicCellReuseIdentifier = @"Topic";

@implementation TopicTableDataSource {
    NSArray *topics;
}

- (void)setTopics:(NSArray *)newTopics {
    topics = newTopics;
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
        topicCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Topic"];
    }
    topicCell.textLabel.text = [[topics objectAtIndex:[indexPath row]] name];
    return topicCell;
}

@end
