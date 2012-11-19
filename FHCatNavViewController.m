//
//  FHCatNavViewController.m
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 06.11.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import "FHCatNavViewController.h"

@interface FHCatNavViewController ()

@end

@implementation FHCatNavViewController

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
    
    UIBarButtonItem *_backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = _backButton;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
