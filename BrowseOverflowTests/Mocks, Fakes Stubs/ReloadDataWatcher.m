//
//  ReloadDataWatcher.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/15/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "ReloadDataWatcher.h"

@implementation ReloadDataWatcher {
    BOOL didReloadData;
}

- (void)reloadData {
    didReloadData = YES;
}
- (BOOL)didReceiveReloadData {
    return didReloadData;
}

@end
