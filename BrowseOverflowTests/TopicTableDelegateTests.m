//
//  TopicTableDelegateTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/12/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "TopicTableDelegateTests.h"
#import "TopicTableDataSource.h"
#import "Topic.h"

@implementation TopicTableDelegateTests {
    NSNotification *receivedNotification;
    TopicTableDataSource *dataSource;
    Topic *iPhoneTopic;
}

- (void)setUp {
    dataSource = [[TopicTableDataSource alloc] init];
    iPhoneTopic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
    [dataSource setTopics:[NSArray arrayWithObject:iPhoneTopic]];
    [[NSNotificationCenter defaultCenter]
            addObserver:self
               selector:@selector(didReceiveNotification:)
                   name:TopicTableDidSelectTopicNotification
                 object:nil];
}

- (void)tearDown {
    receivedNotification = nil;
    dataSource = nil;
    iPhoneTopic = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TopicTableDidSelectTopicNotification object:nil];
}

- (void)didReceiveNotification:(NSNotification *)note {
    receivedNotification = note;
}

- (void)testDelegatePostsNotificationOnSelectionShowingWhichTopicWasSelected {
    NSIndexPath *selection = [NSIndexPath indexPathForRow:0 inSection:0];
    [dataSource tableView:nil didSelectRowAtIndexPath:selection];
    STAssertEqualObjects([receivedNotification name], @"TopicTableDidSelectTopicNotification", @"The delegate should notify that a topic was selected");
    STAssertEqualObjects([receivedNotification object], iPhoneTopic, @"The notification should indicate which topic was selected");
}

@end
