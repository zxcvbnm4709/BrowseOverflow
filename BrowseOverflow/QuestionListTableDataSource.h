//
//  QuestionListTableDataSource.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/14/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Topic;
@class QuestionSummaryCell;
@class AvatarStore;

@interface QuestionListTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property Topic *topic;
@property IBOutlet QuestionSummaryCell *summaryCell;
@property AvatarStore *avatarStore;
@property UITableView *tableView;
@property NSNotificationCenter *notificationCenter;

- (void)registerForUpdatesToAvatarStore:(AvatarStore *)store;
- (void)removeObservationOfUpdatesToAvatarStore:(AvatarStore *)store;
- (void)avatarStoreDidUpdateContent:(NSNotification *)notification;

@end
