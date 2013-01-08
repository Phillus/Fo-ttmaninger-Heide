//
//  FHPersonalTagsViewController.h
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 07.01.13.
//  Copyright (c) 2013 Philipp Sporrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Annotation.h"

@interface FHPersonalTagsViewController : UITableViewController


@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *tagArray;
@property (nonatomic, retain) Annotation *selectedAnnotation;


-(void) updateCurrentAnnotation: (NSString *)title :(NSString *)desc: (NSString *)type;

@end
