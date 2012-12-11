//
//  FHEntityViewController.m
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 05.12.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import "FHEntityViewController.h"

@interface FHEntityViewController ()

@end

@implementation FHEntityViewController
@synthesize pageNumberLabel, myImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"FHEntityViewController" bundle:nil])    {
        
    }
    return self;
}

- (void)viewDidLoad {
    pageNumberLabel.text = [NSString stringWithFormat:@"Page %d", pageNumber + 1];
    //self.view.backgroundColor = [PCTExampleViewController pageControlColorWithIndex:pageNumber];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
