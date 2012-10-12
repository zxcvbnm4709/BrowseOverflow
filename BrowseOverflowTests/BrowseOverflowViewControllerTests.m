//
//  BrowseOverflowViewControllerTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/12/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <objc/runtime.h>
#import "BrowseOverflowViewControllerTests.h"
#import "BrowseOverflowViewController.h"
#import "TopicTableDataSource.h"
#import "EmptyTableViewDelegate.h"

@implementation BrowseOverflowViewControllerTests {
    BrowseOverflowViewController *viewController;
    UITableView *tableView;
}

- (void)setUp {
    viewController = [[BrowseOverflowViewController alloc] init];
    tableView = [[UITableView alloc] init];
    viewController.tableView = tableView;
}

- (void)tearDown {
    viewController = nil;
    tableView = nil;
}

- (void)testViewControllerHasATableViewProperty {
    objc_property_t tableViewProperty = class_getProperty([viewController class], "tableView");
    STAssertTrue(tableViewProperty != NULL, @"BrowseOverflowViewController needs a table view");
}

- (void)testViewControllerHasADataSourceProperty {
    objc_property_t dataSourceProperty = class_getProperty([viewController class], "dataSource");
    STAssertTrue(dataSourceProperty != NULL, @"View Controller needs a data source");
}

- (void)testViewControllerHasATableViewDelegateProperty {
    objc_property_t delegateProperty = class_getProperty([viewController class], "tableViewDelegate");
    STAssertTrue(delegateProperty != NULL, @"View Controller needs a table view delegate");
}

- (void)testViewControllerConnectsDataSourceInViewDidLoad {
    id <UITableViewDataSource> dataSource = [[TopicTableDataSource alloc] init];
    viewController.dataSource = dataSource;
    [viewController viewDidLoad];
    STAssertEqualObjects([tableView dataSource], dataSource, @"View controller should have set the table view's data source");
}

- (void)testViewControllerConnectsDelegateInViewDidLoad {
    id <UITableViewDelegate> delegate = [[EmptyTableViewDelegate alloc] init];
    viewController.tableViewDelegate = delegate;
    [viewController viewDidLoad];
    STAssertEqualObjects([tableView delegate], delegate, @"View controller should have set the table view's delegate");
}

@end
