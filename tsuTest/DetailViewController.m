//
//  DetailViewController.m
//  tsuTest
//
//  Created by Andrey on 2/3/15.
//  Copyright (c) 2015 Svetliy. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *artistImage;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    
        // Update the view.
        [self configureView];

}

- (void)configureView {
    
    self.detailDescriptionLabel.text = [self.artistDetail desc] ;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSString *url = [self.artistDetail img];
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.artistImage.image = [UIImage imageWithData: data];
            
        });
    });

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    NSLog(@"artist: %@", [self.artistDetail title]);
    self.navigationItem.title = [self.artistDetail title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
