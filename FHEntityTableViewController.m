//
//  FHEntityTableViewController.m
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 18.12.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import "FHEntityTableViewController.h"
#import "FHNewPinCategorieViewController.h"
#import "FHAppDelegate.h"
#import "FHCustomEmptyCell.h"

@interface FHEntityTableViewController ()

@end

@implementation FHEntityTableViewController

@synthesize categorie, categorieView, title, desc, navbar, parentSlideshowController, collectionView, managedObjectContext, longPressGesture, myMap, locManager, annotationIsSaved, updatedDesc, updatedTitle, updatedType, update, myCollectionViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINavigationItem *myNavItem = [[UINavigationItem alloc] initWithTitle:@"Bearbeiten"];
    myNavItem.hidesBackButton = YES;
    myNavItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Speichern"
                                                                   style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonIsPressed:)];
    [navbar pushNavigationItem:myNavItem animated:YES];
    
    if (managedObjectContext == nil) {
        managedObjectContext = [(FHAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
    annotationIsSaved = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonIsPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 1){
        return @"Allgemeine Informationen";
    }
    if(section == 2){
        return @"Tags";
    }
    if(section == 3){
        return @"Photos";
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch(section){
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    UILabel *tmpLabel = [[UILabel alloc] init];
    FHCustomEmptyCell *customCell;
    UIButton *button;
    switch (indexPath.section){
        case 0:
            CellIdentifier = @"buttonCell";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            //cell.textLabel.text = title.text;
            button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button addTarget:self
                       action:@selector(backButtonPressed:)
             forControlEvents:UIControlEventTouchDown];
            [button setTitle:@"Zurück" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.frame = CGRectMake(10.0f, 0.0f, 300.0f, 46.0f);
            [button setBackgroundImage:[[UIImage imageNamed:@"blackButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
            [button setBackgroundImage:[[UIImage imageNamed:@"blackButtonHighlighted.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
            [cell addSubview:button];
            return  cell;
            break;
        case 1:
            switch(indexPath.row){
                case 0:
                    CellIdentifier = @"titleCell";
                    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                    //cell.textLabel.text = title.text;
                    tmpLabel = (UILabel *)[cell viewWithTag:002];
                    tmpLabel.text = title.text;
                    title = tmpLabel;
                    return  cell;
                    break;
                case 1:
                    CellIdentifier = @"typeCell";
                    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                    categorie = (UILabel *) [[cell viewWithTag:22] viewWithTag:23];
                    categorieView = (UIView *) [cell viewWithTag:22];
                    return  cell;
                    break;
                case 2:
                    CellIdentifier = @"descCell";
                    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                    tmpLabel = (UILabel *)[cell viewWithTag:32];
                    tmpLabel.text = desc.text;
                    desc = tmpLabel;
                    return  cell;
                    break;
                default:
                    
                    return  cell;
                    break;
            }
            break;
        case 2:
            CellIdentifier = @"mapCell";
            customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            self.myMap = customCell.myMap;
            [self.myMap showsUserLocation];
            
            self.locManager = [[CLLocationManager alloc] init];
            [self.locManager setDelegate:self];
            
            self.locManager.desiredAccuracy = kCLLocationAccuracyKilometer;
            
            // Set a movement threshold for new events.
            self.locManager.distanceFilter = 500;
            [self.locManager startUpdatingLocation];
            [self.myMap addAnnotations:[self getAnnotationsFromCoreData]];
            return cell;
            break;
        case 3:
            CellIdentifier = @"photosCell";
            customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            self.collectionView = customCell.collectionView;
            /*UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
            [aFlowLayout setItemSize:CGSizeMake(200, 140)];
            [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
            myCollectionViewController = [[UICollectionViewController alloc] initWithCollectionViewLayout:aFlowLayout];*/
            return customCell;
            break;
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    switch (indexPath.section){
        case 1:
            if(indexPath.row == 2){
                return 124;
            }else {
                return 44;
            }
            break;
        case 2:
            return 204;
            break;
        case 3:
            return 110;
            break;
    }
    return 44;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0 && indexPath.row == 1){
        FHNewPinCategorieViewController *newPinController = [[FHNewPinCategorieViewController alloc] init];
        newPinController.prevEntityController = self;
        [self presentViewController:newPinController animated:YES completion:nil];
    }
}

#pragma mark - Collection view Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    return cell;
}

/*- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
}*/

#pragma mark Actions

- (void)backButtonPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark MAPS

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
    
    [self addAnnotationToCoreDataWithTitle:title andDesc:desc andType:type andLongitude:[NSNumber numberWithDouble: newAnnotation.coordinate.longitude] andLatitude:[NSNumber numberWithDouble: newAnnotation.coordinate.latitude]];
    
    
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
}

-(void)addAnnotationToCoreDataWithTitle: (NSString *)title andDesc: (NSString *)desc andType: (NSString *)type andLongitude:(NSNumber *)longitude andLatitude:(NSNumber *)latitude {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    //CHECK IF IS ALREADY EXISTING
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Annotation" inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    if(request.entity != nil){
        NSArray *arr = [context executeFetchRequest:request error:&error];
        
        for(Annotation *art in arr){
            if(art.longitude==longitude && art.latitude==latitude){
                return;
            }
        }
    }
    
    // ADD INTO CORE DATA SQL
    
    Annotation *newArticle = [NSEntityDescription insertNewObjectForEntityForName:@"Annotation" inManagedObjectContext:context];
    
    newArticle.title = title;
    newArticle.desc = desc;
    newArticle.type = type;
    newArticle.latitude = latitude;
    newArticle.longitude = longitude;
    
    
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
            if(art.type = @"Vogel"){
                MKPointAnnotation *newAnnotation = [[MKPointAnnotation alloc] init];
                [newAnnotation setCoordinate:CLLocationCoordinate2DMake([art.latitude doubleValue], [art.longitude doubleValue])];
                [newAnnotation setTitle:art.title];
                [newAnnotation setSubtitle:art.desc];
                [self.myMap addAnnotation: newAnnotation];
                [self.myMap selectAnnotation:newAnnotation animated:YES];
                //[returnArr addObject:newAnnotation];
            }
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
                return art;
            }
        }
    }
    
    return nil;
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


@end
