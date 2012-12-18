//
//  FHEntityTableViewController.h
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 18.12.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHDiashowViewController.h"
#import <MapKit/MapKit.h>

@interface FHEntityTableViewController : UITableViewController <UICollectionViewDataSource, MKMapViewDelegate, MKAnnotation, CLLocationManagerDelegate>


@property (strong, nonatomic) UILabel *categorie;
@property (strong, nonatomic) UIView *categorieView;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *desc;
@property (strong, nonatomic) UINavigationBar *navbar;
@property (strong, nonatomic) FHDiashowViewController *parentSlideshowController;

//Map
@property (strong, nonatomic) MKMapView *myMap;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPressGesture;
@property (strong, nonatomic) CLLocationManager *locManager;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
-(void) updateCurrentAnnotation: (NSString *)title :(NSString *)desc: (NSString *)type;
@property BOOL annotationIsSaved;
@property (strong, nonatomic) NSString *updatedTitle;
@property (strong, nonatomic) NSString *updatedDesc;
@property (strong, nonatomic) NSString *updatedType;
@property (nonatomic) BOOL update;

//CollectionView
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewController *myCollectionViewController;


@end
