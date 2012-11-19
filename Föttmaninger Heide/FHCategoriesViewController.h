//
//  FHCategoriesViewController.h
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 06.11.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHCategoriesViewController : UITableViewController

@property (strong, nonatomic) NSDictionary *categoriesArray;
@property (strong, nonatomic) NSMutableArray *statusArray;

@end
