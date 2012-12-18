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
@synthesize pageNumberLabel, myImage, infoButtonView, diashowController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPageNumber:(int)page:(FHDiashowViewController *)diashowControllers {
    if (self = [super initWithNibName:@"FHEntityViewController" bundle:nil])    {
        
    }
    self.diashowController = diashowControllers;
    return self;
}

- (void)viewDidLoad {
    pageNumberLabel.text = [NSString stringWithFormat:@"Page %d", pageNumber + 1];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    
    CGRect buttonFrame = infoButton.frame;
    buttonFrame.origin.x = 290;
    buttonFrame.origin.y = 207;
    infoButton.frame = buttonFrame;
    
    [infoButton addTarget:self action:@selector(infoButtonAction:) forControlEvents:UIControlEventTouchDown];
    //UIBarButtonItem *infoButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:infoButton] autorelease];
    [self.view addSubview:infoButton];
    //self.view.backgroundColor = [PCTExampleViewController pageControlColorWithIndex:pageNumber];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)infoButtonAction:(id)sender
{
    NSLog(@"ACTION");
    [self.diashowController infoButtonAction];
}

@end
