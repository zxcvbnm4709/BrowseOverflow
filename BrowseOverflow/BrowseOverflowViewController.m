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

@interface BrowseOverflowViewController ()

@end

@implementation BrowseOverflowViewController

@synthesize tableView;
@synthesize dataSource;

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
    [[self navigationController] pushViewController:nextViewController animated:YES];
}

@end
