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
#import "QuestionListTableDataSource.h"
#import "BrowseOverflowObjectConfiguration.h"
#import "Topic.h"
#import "TestObjectConfiguration.h"
#import "MockStackOverflowManager.h"
#import "StackOverflowManager.h"
#import "StackOverflowManagerDelegate.h"

static const char *notificationKey = "BrowseOverflowViewControllerTestsAssociatedNotificationKey";
@implementation BrowseOverflowViewController (TestNotificationDelivery)

- (void)browseOverflowControllerTests_userDidSelectTopicNotification:(NSNotification *)note {
    objc_setAssociatedObject(self, notificationKey, note, OBJC_ASSOCIATION_RETAIN);
}

@end

static const char *viewDidAppearKey = "BrowseOverflowViewControllerTestsViewDidAppearKey";
static const char *viewWillDisappearKey = "BrowseOverflowViewControllerTestsViewWillDisappearKey";
@implementation UIViewController (TestSuperclassCalled)

- (void)browseOverflowViewControllerTests_viewDidAppear:(BOOL)animated {
    NSNumber *parameter = [NSNumber numberWithBool:animated];
    objc_setAssociatedObject(self, viewDidAppearKey, parameter, OBJC_ASSOCIATION_RETAIN);
}

- (void)browseOverflowViewControllerTests_viewWillDisappear:(BOOL)animated {
    NSNumber *parameter = [NSNumber numberWithBool:animated];
    objc_setAssociatedObject(self, viewWillDisappearKey, parameter, OBJC_ASSOCIATION_RETAIN);
}

@end

@implementation BrowseOverflowViewControllerTests {
    BrowseOverflowViewController *viewController;
    UITableView *tableView;
    id <UITableViewDataSource, UITableViewDelegate> dataSource;
    SEL realViewDidAppear, testViewDidAppear;
    SEL realViewWillDisappear, testViewWillDisappear;
    SEL realUserDidSelectTopic, testUserDidSelectTopic;
    UINavigationController *navController;
    BrowseOverflowObjectConfiguration *objectConfiguration;
    TestObjectConfiguration *testConfiguration;
    MockStackOverflowManager *manager;
}

+ (void)swapInstanceMethodsForClass:(Class)cls selector:(SEL)sel1 andSelector:(SEL)sel2 {
    Method method1 = class_getInstanceMethod(cls, sel1);
    Method method2 = class_getInstanceMethod(cls, sel2);
    method_exchangeImplementations(method1, method2);
}

- (void)setUp {
    viewController = [[BrowseOverflowViewController alloc] init];
    tableView = [[UITableView alloc] init];
    viewController.tableView = tableView;
    dataSource = [[TopicTableDataSource alloc] init];
    viewController.dataSource = dataSource;
    objc_removeAssociatedObjects(viewController);
    
    realViewDidAppear = @selector(viewDidAppear:);
    testViewDidAppear = @selector(browseOverflowViewControllerTests_viewDidAppear:);
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[UIViewController class] selector:realViewDidAppear andSelector:testViewDidAppear];
    
    realViewWillDisappear = @selector(viewWillDisappear:);
    testViewWillDisappear = @selector(browseOverflowViewControllerTests_viewWillDisappear:);
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[UIViewController class] selector:realViewWillDisappear andSelector:testViewWillDisappear];
    
    realUserDidSelectTopic = @selector(userDidSelectTopicNotification:);
    testUserDidSelectTopic = @selector(browseOverflowControllerTests_userDidSelectTopicNotification:);
    
    navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    objectConfiguration = [[BrowseOverflowObjectConfiguration alloc] init];
    viewController.objectConfiguration = objectConfiguration;
    testConfiguration = [[TestObjectConfiguration alloc] init];
    manager = [[MockStackOverflowManager alloc] init];
    testConfiguration.objectToReturn = manager;
}

- (void)tearDown {
    objc_removeAssociatedObjects(viewController);
    viewController = nil;
    tableView = nil;
    dataSource = nil;
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[UIViewController class] selector:realViewDidAppear andSelector:testViewDidAppear];
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[UIViewController class] selector:realViewWillDisappear andSelector:testViewWillDisappear];
    navController = nil;
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
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectTopic andSelector:testUserDidSelectTopic];
    [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification object:nil userInfo:nil];
    STAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"Notification should not be received before -viewDidAppear");
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectTopic andSelector:testUserDidSelectTopic];
}

- (void)testViewControllerReceivesTableSelectionNotificationAfterViewDidAppear {
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectTopic andSelector:testUserDidSelectTopic];
    [viewController viewDidAppear:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification object:nil userInfo:nil];
    STAssertNotNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewDidAppear: the view controller should handle selcetion notifications");
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectTopic andSelector:testUserDidSelectTopic];
}

- (void)testViewControllerDoesNotReceiveTableSelectNotificationAfterViewWillDisappear {
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectTopic andSelector:testUserDidSelectTopic];
    [viewController viewDidAppear:NO];
    [viewController viewWillDisappear:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:TopicTableDidSelectTopicNotification object:nil userInfo:nil];
    STAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewWillDisappear: is called, the view controller should no longer respond to topic selection notifications");
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass:[BrowseOverflowViewController class] selector:realUserDidSelectTopic andSelector:testUserDidSelectTopic];
}

- (void)testViewControllerCallsSuperViewDidAppear {
    [viewController viewDidAppear:NO];
    STAssertNotNil(objc_getAssociatedObject(viewController, viewDidAppearKey), @"viewDidAppear: should call through to superclass implementation");
}

- (void)testViewControllerCallsSuperViewWillDisappear {
    [viewController viewWillDisappear:NO];
    STAssertNotNil(objc_getAssociatedObject(viewController, viewWillDisappearKey), @"viewWillDisappear: should call through to superclass implementation");
}

- (void)testSelectingTopicPushesNewViewController {
    [viewController userDidSelectTopicNotification:nil];
    UIViewController *currentTopVC = navController.topViewController;
    STAssertFalse([currentTopVC isEqual:viewController], @"New view controller should be pushed onto the stack");
    STAssertTrue([currentTopVC isKindOfClass:[BrowseOverflowViewController class]], @"New view controller should be a BrowseOverflowViewController");
}

- (void)testNewViewControllerHasAQuestionListDataSourceForTheSelectedTopic {
    Topic *iPhoneTopic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
    NSNotification *iPhoneTopicSelectedNotification = [NSNotification notificationWithName:TopicTableDidSelectTopicNotification object:iPhoneTopic];
    [viewController userDidSelectTopicNotification:iPhoneTopicSelectedNotification];
    BrowseOverflowViewController *nextViewController = (BrowseOverflowViewController *)navController.topViewController;
    STAssertTrue([nextViewController.dataSource isKindOfClass:[QuestionListTableDataSource class]], @"Selecting a topic should push a list of questions");
    STAssertEqualObjects([(QuestionListTableDataSource *)nextViewController.dataSource topic], iPhoneTopic, @"The questions to display should come from the selected topic");
}

- (void)testViewControllerConnectsTableViewBacklinkInViewDidLoad {
    QuestionListTableDataSource *questionDataSource = [[QuestionListTableDataSource alloc] init];
    viewController.dataSource = questionDataSource;
    [viewController viewDidLoad];
    STAssertEqualObjects(questionDataSource.tableView, tableView, @"Back-link to table view should be set in data source");
}

- (void)testSelectingTopicNotificationPassesObjectConfiguration {
    [viewController userDidSelectTopicNotification:nil];
    BrowseOverflowViewController *newTopVC = (BrowseOverflowViewController *)navController.topViewController;
    STAssertEqualObjects(newTopVC.objectConfiguration, objectConfiguration, @"The object configuration should be passed through to the new view controller");
}

- (void)testViewWillAppearOnQuestionListInitiatesLoadingOfQuestions {
    viewController.objectConfiguration = testConfiguration;
    viewController.dataSource = [[QuestionListTableDataSource alloc] init];
    [viewController viewWillAppear:YES];
    STAssertTrue([manager didFetchQuestions], @"View controller should have arranged for question content to be downloaded");
}

- (void)testViewControllerConformsToStackOverflowManagerDelegateProtocol {
    STAssertTrue([viewController conformsToProtocol:@protocol(StackOverflowManagerDelegate)], @"View controllers need to be StackOverflowManagerDelegate");
}

- (void)testViewControllerConfiguredAsStackOverflowManagerDelegateOnManagerCreation {
    [viewController viewWillAppear:YES];
    STAssertEquals(viewController.manager.delegate, viewController, @"View controller sets itself as the manager's delegate");
}

@end
