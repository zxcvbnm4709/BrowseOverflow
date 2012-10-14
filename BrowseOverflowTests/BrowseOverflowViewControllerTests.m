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

static const char *notificationKey = "BrowseOverflowViewControllerTestsAssociatedNotificationKey";
@implementation BrowseOverflowViewController (TestNotificationDelivery)

- (void)userDidSelectTopicNotification:(NSNotification *)note {
    objc_setAssociatedObject(self, notificationKey, note, OBJC_ASSOCIATION_RETAIN);
}

@end

@implementation BrowseOverflowViewControllerTests {
    BrowseOverflowViewController *viewController;
    UITableView *tableView;
    id <UITableViewDataSource, UITableViewDelegate> dataSource;
}

- (void)setUp {
    viewController = [[BrowseOverflowViewController alloc] init];
    tableView = [[UITableView alloc] init];
    viewController.tableView = tableView;
    dataSource = [[TopicTableDataSource alloc] init];
    viewController.dataSource = dataSource;
    objc_removeAssociatedObjects(viewController);
}

- (void)tearDown {
    objc_removeAssociatedObjects(viewController);
    viewController = nil;
    tableView = nil;
    dataSource = nil;
}

- (void)testViewControllerHasATableViewProperty {
    objc_property_t tableViewProperty = class_getProperty([viewController class], "tableView");
    STAssertTrue(tableViewProperty != NULL, @"BrowseOverflowViewController needs a table view");
}

- (void)testViewControllerHasADataSourceProperty {
    objc_property_t dataSourceProperty = class_getProperty([viewController class], "dataSource");
    STAssertTrue(dataSourceProperty != NULL, @"View Controller needs a data source");
}

- (void)testViewControllerConnectsDataSourceInViewDidLoad {
    [viewController viewDidLoad];
    STAssertEqualObjects([tableView dataSource], dataSource, @"View controller should have set the table view's data source");
}

- (void)testViewControllerConnectsDelegateInViewDidLoad {
    [viewController viewDidLoad];
    STAssertEqualObjects([tableView delegate], dataSource, @"View controller should have set the table view's delegate");
}

- (void)testDefaultStateOfViewControllerDoesNotReceiveNotifications {
    [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification object:nil userInfo:nil];
    STAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"Notification should not be received before -viewDidAppear");
}

- (void)testViewControllerReceivesTableSelectionNotificationAfterViewDidAppear {
    [viewController viewDidAppear:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification object:nil userInfo:nil];
    STAssertNotNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewDidAppear: the view controller should handle selcetion notifications");
}

- (void)testViewControllerDoesNotReceiveTableSelectNotificationAfterViewWillDisappear {
    [viewController viewDidAppear:NO];
    [viewController viewWillDisappear:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification object:nil userInfo:nil];
    STAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewWillDisappear: is called, the view controller should no longer respond to topic selection notifications");
}

@end
