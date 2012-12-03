//
//  FHNewPinCategorieViewController.h
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 26.11.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHAddPinViewController.h"

@interface FHNewPinCategorieViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *catArr;
@property (strong, nonatomic) NSMutableArray *colorArr;
@property (strong, nonatomic) NSString *categorie;
@property (strong, nonatomic) FHAddPinViewController *prevController;

@end
