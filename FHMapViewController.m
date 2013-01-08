//
//  FHMapViewController.m
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 12.11.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import "FHMapViewController.h"
#import "FHAddPinViewController.h"
#import "FHAppDelegate.h"
#import "Annotation.h"

@interface FHMapViewController ()

@end


@implementation FHMapViewController

@synthesize longPressGesture, touchPoint, locManager, createNewAnnotaion, myMap, managedObjectContext, annotationIsSaved;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (managedObjectContext == nil) {
        managedObjectContext = [(FHAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
    annotationIsSaved = YES;
    
    [self.myMap showsUserLocation];
    
    self.locManager = [[CLLocationManager alloc] init];
    [self.locManager setDelegate:self];
    
    self.locManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    self.locManager.distanceFilter = 500;
    [self.locManager startUpdatingLocation];
    [self.myMap addAnnotations:[self getAnnotationsFromCoreData]];
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
        
        if(annotationIsSaved == NO){
            id<MKAnnotation> currentAnn = [self.myMap.selectedAnnotations objectAtIndex:0];
            [self.myMap removeAnnotation:currentAnn];
        }
        
        touchPoint = [self.longPressGesture locationInView:self.myMap];
        CLLocationCoordinate2D touchMapCoordinate =
        [self.myMap convertPoint:touchPoint toCoordinateFromView:self.myMap];
        
        MKPointAnnotation *newAnnotation = [[MKPointAnnotation alloc] init];
        [newAnnotation setCoordinate:touchMapCoordinate];
        [newAnnotation setTitle:@"Object at"];
        [newAnnotation setSubtitle:@"Coordinates"];
        
        [self.myMap addAnnotation: newAnnotation];
        [self.myMap selectAnnotation:newAnnotation animated:YES];
        annotationIsSaved = NO;
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
    
    if(createNewAnnotaion == YES && annotationIsSaved == YES){
        
        CLLocationCoordinate2D touchMapCoordinate =
        [self.myMap convertPoint:touchPoint toCoordinateFromView:self.myMap];
        
        MKPointAnnotation *newAnnotation = [[MKPointAnnotation alloc] init];
        [newAnnotation setCoordinate:touchMapCoordinate];
        [newAnnotation setTitle:@"Object at"];
        [newAnnotation setSubtitle:@"Coordinates"];
        
        [self.myMap addAnnotation: newAnnotation];
        [self.myMap selectAnnotation:newAnnotation animated:YES];
        
        createNewAnnotaion = NO;
        annotationIsSaved = NO;
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
    annotationIsSaved = YES;
    
    [self.myMap removeAnnotation:currentAnnotation];
    
    [self addAnnotationToCoreDataWithTitle:title andDesc:desc andType:type andLongitude:newAnnotation.coordinate.longitude andLatitude:newAnnotation.coordinate.latitude];
    
    
    [self.myMap selectAnnotation:newAnnotation animated:YES];
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"createPin" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id<MKAnnotation> currentAnnotation = [self.myMap.selectedAnnotations objectAtIndex:0];
    Annotation *coreDataAnnotation = [self getAnnotationForMKAnnotation: currentAnnotation];
    FHAddPinViewController *pinViewController = (FHAddPinViewController *) segue.destinationViewController;
    
    pinViewController.parentMapController = self;
    pinViewController.title = [[UILabel alloc] init];
    pinViewController.title.text = coreDataAnnotation.title;
    pinViewController.desc = [[UILabel alloc] init];
    pinViewController.desc.text = coreDataAnnotation.desc;
    pinViewController.categorie = [[UILabel alloc] init];
    pinViewController.categorie.text = coreDataAnnotation.type;
    [pinViewController setHidesBottomBarWhenPushed:YES];
    
    NSLog(@"type when catched: %@", coreDataAnnotation.type);
}

-(void)addAnnotationToCoreDataWithTitle: (NSString *)title andDesc: (NSString *)desc andType: (NSString *)type andLongitude:(double)longitude andLatitude:(double)latitude {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    //CHECK IF IS ALREADY EXISTING
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Annotation" inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    if(request.entity != nil){
        NSArray *arr = [context executeFetchRequest:request error:&error];
        
        for(Annotation *art in arr){
            if([art.longitude doubleValue]==longitude && [art.latitude doubleValue]==latitude){
                NSLog(@"existing");
                art.type = type;
                art.title = self.updatedTitle;
                art.desc = self.updatedDesc;
                NSLog(@"type when saved: %@",type);
                
                if(![context save:&error]){
                    NSLog(@"DEPP");
                }

                return;
            }
        }
    }
    
    // ADD INTO CORE DATA SQL
    
    Annotation *newArticle = [NSEntityDescription insertNewObjectForEntityForName:@"Annotation" inManagedObjectContext:context];
    
    newArticle.title = title;
    newArticle.desc = desc;
    newArticle.type = type;
    newArticle.latitude = [NSNumber numberWithDouble: latitude];
    newArticle.longitude = [NSNumber numberWithDouble: longitude];
    NSLog(@"type when saved: %@",type);
    
    if(![context save:&error]){
        NSLog(@"DEPP");
    }

    
}

-(NSMutableArray *)getAnnotationsFromCoreData {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    NSMutableArray *returnArr = [[NSMutableArray alloc]init];
    
    //REQUEST
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Annotation" inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    if(request.entity != nil){
        NSArray *arr = [context executeFetchRequest:request error:&error];
        
        for(Annotation *art in arr){
            MKPointAnnotation *newAnnotation = [[MKPointAnnotation alloc] init];
            [newAnnotation setCoordinate:CLLocationCoordinate2DMake([art.latitude doubleValue], [art.longitude doubleValue])];
            [newAnnotation setTitle:art.title];
            [newAnnotation setSubtitle:art.desc];
            [self.myMap addAnnotation: newAnnotation];
            [self.myMap selectAnnotation:newAnnotation animated:YES];
            //[returnArr addObject:newAnnotation];
        }
    }
    return returnArr;
}

-(Annotation *) getAnnotationForMKAnnotation: (MKPointAnnotation *)pointAnnotation {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    //REQUEST
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Annotation" inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    if(request.entity != nil){
        NSArray *arr = [context executeFetchRequest:request error:&error];
        
        for(Annotation *art in arr){
            if([art.latitude doubleValue]==pointAnnotation.coordinate.latitude && [art.longitude doubleValue]==pointAnnotation.coordinate.longitude){
                NSLog(@"art.type = %@",art.type);
                return art;
            }
        }
    }
    
    
    return nil;
}

@end
