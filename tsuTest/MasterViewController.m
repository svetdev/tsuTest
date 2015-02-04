//
//  MasterViewController.m
//  tsuTest
//
//  Created by Andrey on 2/3/15.
//  Copyright (c) 2015 Svetliy. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property NSMutableArray *artists;
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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.artists = [[NSMutableArray alloc] init];
    [self getDataFromParse];

    
   
    
    
    
    
}

- (void) getDataFromParse {
    
    PFQuery *myQuery = [PFQuery queryWithClassName:@"Artists"];
    [myQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu artists.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                Artist *newArt = [[Artist alloc] init];
                newArt.title = object[@"title"];
                newArt.desc = object[@"description"];
                newArt.img = object[@"image"];
                newArt.createdAt = object.createdAt;
                NSLog(@"%@", object.objectId);
                [self.artists addObject:newArt];
                [self.tableView reloadData];
        
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
   
    
   
    
    // The InBackground methods are asynchronous, so any code after this will run
    // immediately.  Any code that depends on the query result should be moved
    // inside the completion block above.
    
}

-(void)notificationReceived:(NSNotification *)notification {
    
    NSLog(@"RECEIVED");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Artist *object = self.artists[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setArtistDetail:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.artists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = [self.artists[indexPath.row] title];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[self.artists[indexPath.row] createdAt]
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    cell.detailTextLabel.text = dateString;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSString *url = [self.artists[indexPath.row] img];
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData: data];
            [self.tableView reloadData];
        });
    });
    
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

@end
