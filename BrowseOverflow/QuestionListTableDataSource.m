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

@implementation QuestionListTableDataSource

@synthesize topic;
@synthesize summaryCell;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[topic recentQuestions] count] ?: 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if ([topic.recentQuestions count]) {
        Question *question = [topic.recentQuestions objectAtIndex:indexPath.row];
        summaryCell = [tableView dequeueReusableCellWithIdentifier:@"question"];
        if (!summaryCell) {
            [[NSBundle bundleForClass:[self class]] loadNibNamed:@"QuestionSummaryCell" owner:self options:nil];
        }
        summaryCell.titleLabel.text = question.title;
        summaryCell.scoreLabel.text = [NSString stringWithFormat:@"%d", question.score];
        summaryCell.nameLabel.text = question.asker.name;
        
        cell = summaryCell;
        summaryCell = nil;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"placeholder"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"placeholder"];
        }
        cell.textLabel.text = @"There was a problem connecting to the network.";
    }
    return cell;
}

@end
