//
//  QuestionListTableDataSource.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/14/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "QuestionListTableDataSource.h"
#import "Question.h"
#import "Person.h"
#import "Topic.h"
#import "QuestionSummaryCell.h"
#import "AvatarStore.h"

@implementation QuestionListTableDataSource

@synthesize topic;
@synthesize summaryCell;
@synthesize avatarStore;
@synthesize tableView;
@synthesize notificationCenter;

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [[topic recentQuestions] count] ?: 1;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if ([topic.recentQuestions count]) {
        Question *question = [topic.recentQuestions objectAtIndex:indexPath.row];
        summaryCell = [aTableView dequeueReusableCellWithIdentifier:@"question"];
        if (!summaryCell) {
            [[NSBundle bundleForClass:[self class]] loadNibNamed:@"QuestionSummaryCell" owner:self options:nil];
        }
        summaryCell.titleLabel.text = question.title;
        summaryCell.scoreLabel.text = [NSString stringWithFormat:@"%d", question.score];
        summaryCell.nameLabel.text = question.asker.name;
        
        NSData *avatarData = [avatarStore dataForURL:question.asker.avatarURL];
        if (avatarData) {
            summaryCell.avatarView.image = [UIImage imageWithData:avatarData];
        }
        
        cell = summaryCell;
        summaryCell = nil;
    } else {
        cell = [aTableView dequeueReusableCellWithIdentifier:@"placeholder"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"placeholder"];
        }
        cell.textLabel.text = @"There was a problem connecting to the network.";
    }
    return cell;
}

- (void)registerForUpdatesToAvatarStore:(AvatarStore *)store {
    [notificationCenter addObserver:self selector:@selector(avatarStoreDidUpdateContent:) name:AvatarStoreDidUpdateContentNotification object:store];
}

- (void)removeObservationOfUpdatesToAvatarStore:(AvatarStore *)store {
    [notificationCenter removeObserver:self name:AvatarStoreDidUpdateContentNotification object:store];
}

- (void)avatarStoreDidUpdateContent:(NSNotification *)notification {
    [tableView reloadData];
}

@end
