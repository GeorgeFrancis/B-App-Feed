//
//  DetailViewController.m
//  b-intheknow
//
//  Created by George Francis on 21/10/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "DetailViewController.h"
#import "BaseClass.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
    //    [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
   //     self.detailDescriptionLabel.text = [self.detailItem.body];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BaseClass *feedO =(BaseClass*)self.detailItem;

    // Do any additional setup after loading the view, typically from a nib.
  //  [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
