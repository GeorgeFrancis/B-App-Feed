//
//  MasterViewController.m
//  b-intheknow
//
//  Created by George Francis on 21/10/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "DataModels.h"
#import <RestKit/RestKit.h>
#import "CustomCellTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MasterViewController (){

    NSArray *feedObjects;
    NSMutableArray *feedArray;
//    NSMutableArray *_objects;
}

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    
   
    [super viewDidLoad];
    feedArray = [[NSMutableArray alloc]init];
    
    [self configureRestKit];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(RKResponseDescriptor *)responseDescriptor {
    
    RKObjectMapping *bodyMapping = [RKObjectMapping mappingForClass:[BaseClass class]];
    [bodyMapping addAttributeMappingsFromArray:@[@"body",@"title",@"url"]];
    
     RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:bodyMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return responseDescriptor;
}

-(void)configureRestKit{
    
    NSURL *baseURL = [NSURL URLWithString:@"http://bintheknow-dev.azurewebsites.net/api/feeds/bintheknow/15"];
    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[[self responseDescriptor]]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        feedObjects = mappingResult.array;
        
      //  [feedArray addObjectsFromArray:feedObjects];
        
        
      //  [feedArray addObject:feedObjects];
        [self.tableView reloadData];
        
        RKLogInfo(@"Load collection of Feeds: %@", mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    
    [objectRequestOperation start];
}

     
- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        long row = indexPath.row;
        NSArray *feedarray = feedObjects[row];
        
        BaseClass *feedO = feedarray[row];
        [[segue destinationViewController] setDetailItem:feedO];

    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return feedObjects.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCellTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];

    BaseClass *feedO = feedObjects[indexPath.row];
    
    
    if ([feedO.title  isEqual: @"undefined"]) {
        customCell.customCellTextLabel.text = @"Url Image to be used";
        customCell.customCellImageView.image = [UIImage imageNamed:@"loadingImage.gif"];
    }
 
    else {
        
    
    customCell.customCellTextLabel.text = [NSString stringWithFormat:@"%@",feedO.title];
    
    NSString *string = [NSString stringWithFormat:@"%@",feedO.body];
    
        NSURL *urlString;
        
        customCell.customCellImageView.image =nil;
    
        NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        NSArray *matches = [linkDetector matchesInString:string options:0 range:NSMakeRange(0, [string length])];
        for (NSTextCheckingResult *match in matches) {
            if ([match resultType] == NSTextCheckingTypeLink) {
                urlString = [match URL];
                NSLog(@"found Body URL: %@ and title %@", urlString,feedO.title);
                            }
        }
        
        NSString *myString = [urlString absoluteString];
        
        [customCell.customCellImageView sd_setImageWithURL: [NSURL URLWithString:myString]];
        
   }
    
    return customCell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
