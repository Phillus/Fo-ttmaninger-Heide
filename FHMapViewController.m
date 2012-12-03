//
//  FHMapViewController.m
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 12.11.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import "FHMapViewController.h"
#import "FHAddPinViewController.h"

@interface FHMapViewController ()

@end


@implementation FHMapViewController

@synthesize longPressGesture, touchPoint, locManager, createNewAnnotaion, myMap;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.myMap showsUserLocation];
    
    self.locManager = [[CLLocationManager alloc] init];
    [self.locManager setDelegate:self];
    
    self.locManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    self.locManager.distanceFilter = 500;
    [self.locManager startUpdatingLocation];
}

-(void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation  {
    
    CLLocationCoordinate2D loc = [newLocation coordinate];
    
    
    [self.myMap setCenterCoordinate:loc animated:YES];
    MKCoordinateRegion myRegion;
    myRegion.center.latitude = loc.latitude;
    myRegion.center.longitude = loc.longitude;
    myRegion.span.latitudeDelta = 0.03f;
    myRegion.span.longitudeDelta = 0.03f;
    [self.myMap setRegion:myRegion animated:YES];
    
}

-(IBAction)longPress:(UILongPressGestureRecognizer *)recognizer {
    self.longPressGesture = recognizer;
    if(recognizer.state == UIGestureRecognizerStateEnded){
        
    }else if(recognizer.state == UIGestureRecognizerStateBegan){
        
        touchPoint = [self.longPressGesture locationInView:self.myMap];
        CLLocationCoordinate2D touchMapCoordinate =
        [self.myMap convertPoint:touchPoint toCoordinateFromView:self.myMap];
        
        MKPointAnnotation *newAnnotation = [[MKPointAnnotation alloc] init];
        [newAnnotation setCoordinate:touchMapCoordinate];
        [newAnnotation setTitle:@"Object at"];
        [newAnnotation setSubtitle:@"Coordinates"];
        
        [self.myMap addAnnotation: newAnnotation];
        [self.myMap selectAnnotation:newAnnotation animated:YES];
        
        [self.myMap removeGestureRecognizer:recognizer];
        
    }else {
        
    }
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    

    
    if(self.longPressGesture){
        [self.myMap addGestureRecognizer:self.longPressGesture];
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(createNewAnnotaion == YES){
        
        CLLocationCoordinate2D touchMapCoordinate =
        [self.myMap convertPoint:touchPoint toCoordinateFromView:self.myMap];
        
        MKPointAnnotation *newAnnotation = [[MKPointAnnotation alloc] init];
        [newAnnotation setCoordinate:touchMapCoordinate];
        [newAnnotation setTitle:@"Object at"];
        [newAnnotation setSubtitle:@"Coordinates"];
        
        [self.myMap addAnnotation: newAnnotation];
        [self.myMap selectAnnotation:newAnnotation animated:YES];
        
        createNewAnnotaion = NO;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if (annotation==self.myMap.userLocation ) {
        return nil;
    }else {
        MKPinAnnotationView *pinView = (MKPinAnnotationView *) [self.myMap dequeueReusableAnnotationViewWithIdentifier:@"pinView"];
        if(!pinView){
            pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pinView"];
            pinView.pinColor = MKPinAnnotationColorRed;
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            
            UIButton *discButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.rightCalloutAccessoryView = discButton;
        }else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
}
-(void) updateCurrentAnnotation: (NSString *)title :(NSString *)desc: (NSString *)type {
    self.updatedTitle = title;
    self.updatedDesc = desc;
    self.updatedType = type;
    self.update = YES;
    id<MKAnnotation> currentAnnotation = [self.myMap.selectedAnnotations objectAtIndex:0];
    MKPointAnnotation *newAnnotation = [[MKPointAnnotation alloc] init];
    [newAnnotation setCoordinate:[currentAnnotation coordinate]];
    [newAnnotation setTitle:self.updatedTitle];
    [newAnnotation setSubtitle:self.updatedDesc];
    [self.myMap addAnnotation: newAnnotation];
    [self.myMap selectAnnotation:newAnnotation animated:YES];
    
    [self.myMap removeAnnotation:currentAnnotation];
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"createPin" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id<MKAnnotation> currentAnnotation = [self.myMap.selectedAnnotations objectAtIndex:0];
    FHAddPinViewController *pinViewController = (FHAddPinViewController *) segue.destinationViewController;
    pinViewController.parentMapController = self;
    pinViewController.title = [[UILabel alloc] init];
    pinViewController.title.text = [currentAnnotation title];
    pinViewController.desc = [[UILabel alloc] init];
    pinViewController.desc.text = [currentAnnotation subtitle];
    NSLog(@"title: %@",[currentAnnotation title]);
    [pinViewController setHidesBottomBarWhenPushed:YES];
}

@end
