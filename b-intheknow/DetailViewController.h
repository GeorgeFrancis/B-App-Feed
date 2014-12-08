//
//  DetailViewController.h
//  b-intheknow
//
//  Created by George Francis on 21/10/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

