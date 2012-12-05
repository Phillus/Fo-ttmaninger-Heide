//
//  FHAppDelegate.h
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 06.11.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Annotation.h"

@interface FHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
