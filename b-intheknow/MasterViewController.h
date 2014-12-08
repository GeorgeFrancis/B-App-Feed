//
//  MasterViewController.h
//  b-intheknow
//
//  Created by George Francis on 21/10/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCellTableViewCell.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate >

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

