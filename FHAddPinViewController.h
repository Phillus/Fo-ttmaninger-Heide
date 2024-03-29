//
//  FHAddPinViewController.h
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 19.11.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHMapViewController.h"
#import "FHPersonalTagsViewController.h"

@interface FHAddPinViewController : UITableViewController

@property (strong, nonatomic) UILabel *categorie;
@property (strong, nonatomic) UIView *categorieView;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UITextField *desc;
@property (strong, nonatomic) FHMapViewController *parentMapController;
@property (strong, nonatomic) FHPersonalTagsViewController *parentParsonalTagController;

@end
