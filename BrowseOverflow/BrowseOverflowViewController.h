//
//  BrowseOverflowViewController.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/12/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackOverflowManagerDelegate.h"

@class BrowseOverflowObjectConfiguration;
@class StackOverflowManager;

@interface BrowseOverflowViewController : UIViewController <StackOverflowManagerDelegate>

@property IBOutlet UITableView *tableView;
@property NSObject <UITableViewDataSource, UITableViewDelegate> *dataSource;
@property BrowseOverflowObjectConfiguration *objectConfiguration;
@property StackOverflowManager *manager;

- (void)userDidSelectTopicNotification: (NSNotification *)note;

@end
