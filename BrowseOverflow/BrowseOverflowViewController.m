//
//  BrowseOverflowViewController.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/12/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "BrowseOverflowViewController.h"
#import "TopicTableDataSource.h"
#import "QuestionListTableDataSource.h"
#import <objc/runtime.h>
#import "BrowseOverflowObjectConfiguration.h"
#import "StackOverflowManager.h"
#import "Topic.h"

@interface BrowseOverflowViewController ()

@end

@implementation BrowseOverflowViewController

@synthesize tableView;
@synthesize dataSource;
@synthesize objectConfiguration;
@synthesize manager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self.dataSource;
    self.tableView.dataSource = self.dataSource;
    objc_property_t tableViewProperty = class_getProperty([dataSource class], "tableView");
    if (tableViewProperty) {
        [dataSource setValue:tableView forKey:@"tableView"];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.manager = [objectConfiguration stackOverflowManager];
    self.manager.delegate = self;
    if ([self.dataSource isKindOfClass:[QuestionListTableDataSource class]]) {
        Topic *selectedTopic = [(QuestionListTableDataSource *)self.dataSource topic];
        [self.manager fetchQuestionsOnTopic:selectedTopic];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidSelectTopicNotification:) name:TopicTableDidSelectTopicNotification object:nil];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TopicTableDidSelectTopicNotification object:nil];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userDidSelectTopicNotification: (NSNotification *)note {
    Topic *selectedTopic = (Topic *)[note object];
    BrowseOverflowViewController *nextViewController = [[BrowseOverflowViewController alloc] init];
    QuestionListTableDataSource *questionsDataSource = [[QuestionListTableDataSource alloc] init];
    questionsDataSource.topic = selectedTopic;
    nextViewController.dataSource = questionsDataSource;
    nextViewController.objectConfiguration = self.objectConfiguration;
    [[self navigationController] pushViewController:nextViewController animated:YES];
}

#pragma mark - StackOverflowManagerDelegate

- (void)fetchingQuestionsFailedWithError:(NSError *)error {
    
}

- (void)didReceiveQuestions:(NSArray *)questions {
    Topic *topic = ((QuestionListTableDataSource *)self.dataSource).topic;
    for (Question *thisQuestion in questions) {
        [topic addQuestion:thisQuestion];
    }
    [tableView reloadData];
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error {
    
}

- (void)retrievingAnswersFailedWithError:(NSError *)error {
    
}

- (void)answersReceivedForQuestion:(Question *)question {
    [tableView reloadData];
}

- (void)bodyReceivedForQuestion:(Question *)question {
    [tableView reloadData];
}

@end
