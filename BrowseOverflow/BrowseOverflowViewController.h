//
//  BrowseOverflowViewController.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/12/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseOverflowViewController : UIViewController

@property IBOutlet UITableView *tableView;
@property NSObject <UITableViewDataSource, UITableViewDelegate> *dataSource;

- (void)userDidSelectTopicNotification: (NSNotification *)note;

@end
