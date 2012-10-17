//
//  BrowseOverflowAppDelegateTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/16/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "BrowseOverflowAppDelegateTests.h"
#import "BrowseOverflowAppDelegate.h"
#import "BrowseOverflowViewController.h"
#import "TopicTableDataSource.h"

@implementation BrowseOverflowAppDelegateTests {
    UIWindow *window;
    UINavigationController *navigationController;
    BrowseOverflowAppDelegate *appDelegate;
}

- (void)setUp {
    window = [[UIWindow alloc] init];
    navigationController = [[UINavigationController alloc] init];
    appDelegate = [[BrowseOverflowAppDelegate alloc] init];
    appDelegate.window = window;
    appDelegate.navigationController = navigationController;
}

- (void)tearDown {
    window = nil;
    navigationController = nil;
    appDelegate = nil;
}

- (void)testWindowIsKeyAfterApplicationLaunch {
    [appDelegate application:nil didFinishLaunchingWithOptions:nil];
    STAssertTrue(window.keyWindow, @"App delegate's window should be key");
}

- (void)testWindowHasRootNavigationControllerAfterApplicationLaunch {
    [appDelegate application:nil didFinishLaunchingWithOptions:nil];
    STAssertEqualObjects(window.rootViewController, navigationController, @"App delegate's navigation controller should be the root VC");
}

- (void)testAppDidFinishLaunchingReturnsYES {
    STAssertTrue([appDelegate application:nil didFinishLaunchingWithOptions:nil], @"Method should return YES");
}

- (void)testNavigationControllerShowsABrowseOverflowController {
    [appDelegate application:nil didFinishLaunchingWithOptions:nil];
    id visibleViewController = appDelegate.navigationController.topViewController;
    STAssertTrue([visibleViewController isKindOfClass:[BrowseOverflowViewController class]], @"Views in this app are supplied by BrowseOverflowViewControllers");
}

- (void)testFirstViewControllerHasATopicTableDataSource {
    [appDelegate application:nil didFinishLaunchingWithOptions:nil];
    BrowseOverflowViewController *viewController = (BrowseOverflowViewController *)appDelegate.navigationController.topViewController;
    STAssertTrue([viewController.dataSource isKindOfClass:[TopicTableDataSource class]], @"First view should display a list of topics");
}

- (void)testTopicListIsNotEmptyOnAppLaunch {
    [appDelegate application:nil didFinishLaunchingWithOptions:nil];
    id <UITableViewDataSource, UITableViewDelegate> dataSource = [(BrowseOverflowViewController *)[appDelegate.navigationController topViewController] dataSource];
    STAssertFalse([dataSource tableView:nil numberOfRowsInSection:0] == 0, @"There should be some rows to display");
}

- (void)testFirstViewControllerHasAnObjectConfiguration {
    [appDelegate application:nil didFinishLaunchingWithOptions:nil];
    BrowseOverflowViewController *topicViewController = (BrowseOverflowViewController *)[appDelegate.navigationController topViewController];
    STAssertNotNil(topicViewController.objectConfiguration, @"The view controller should have an object configuration instance");
}

@end
