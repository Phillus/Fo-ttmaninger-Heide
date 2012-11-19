//
//  FHMapViewController.h
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 12.11.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FHMapViewController : UIViewController <MKMapViewDelegate, MKAnnotation, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *myMap;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPressGesture;
@property (strong, nonatomic) CLLocationManager *locManager;
@property (nonatomic) BOOL createNewAnnotaion;
@property (nonatomic) CGPoint touchPoint;

-(IBAction)longPress:(UILongPressGestureRecognizer *)recognizer;

@end