//
//  DetailViewController.h
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/5/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
