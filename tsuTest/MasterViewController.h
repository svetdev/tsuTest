//
//  MasterViewController.h
//  tsuTest
//
//  Created by Andrey on 2/3/15.
//  Copyright (c) 2015 Svetliy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "Artist.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

