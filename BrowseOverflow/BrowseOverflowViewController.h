//
//  BrowseOverflowViewController.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/12/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseOverflowViewController : UIViewController

@property UITableView *tableView;
@property id <UITableViewDataSource> dataSource;
@property id <UITableViewDelegate> tableViewDelegate;

@end
