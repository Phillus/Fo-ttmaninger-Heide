//
//  FHPersonalTagsViewController.m
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 07.01.13.
//  Copyright (c) 2013 Philipp Sporrer. All rights reserved.
//

#import "FHPersonalTagsViewController.h"
#import "FHAppDelegate.h"
#import "FHAddPinViewController.h"

@interface FHPersonalTagsViewController ()

@end

@implementation FHPersonalTagsViewController

@synthesize managedObjectContext, tagArray, selectedAnnotation;

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
    
    if (managedObjectContext == nil) {
        managedObjectContext = [(FHAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    
    tagArray = [[NSMutableArray alloc] init];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    
    tagArray = [self getAnnotationsFromCoreData];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1; //Anzahl Kategorien
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [tagArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Annotation *currentTag = [tagArray objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"tagCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = currentTag.title;
    cell.detailTextLabel.text = currentTag.desc;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    return 60;
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
    NSLog(@"did select row at index path");
    self.selectedAnnotation = [tagArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showEntityDetails" sender:self];
}

#pragma mark CoreData

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
            [returnArr addObject: art];
        }
    }
    return returnArr;
}

-(void) updateCurrentAnnotation: (NSString *)title :(NSString *)desc: (NSString *)type {
    
    [self addAnnotationToCoreDataWithTitle:title andDesc:desc andType:type andLongitude:selectedAnnotation.longitude andLatitude:selectedAnnotation.latitude];
    
    tagArray = [[NSMutableArray alloc] init];
    [self.tableView reloadData];
    
}

- (void)addAnnotationToCoreDataWithTitle: (NSString *)title andDesc: (NSString *)desc andType: (NSString *)type andLongitude:(NSNumber *)longitude andLatitude:(NSNumber *)latitude {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    //CHECK IF IS ALREADY EXISTING
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Annotation" inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    if(request.entity != nil){
        NSArray *arr = [context executeFetchRequest:request error:&error];
        
        for(Annotation *art in arr){
            if([art.longitude isEqualToNumber: longitude] && [art.latitude isEqualToNumber: latitude]){
                NSLog(@"existing");
                art.type = type;
                art.title = title;
                art.desc = desc;
                
                if(![context save:&error]){
                    NSLog(@"DEPP");
                }
                
                return;
            }
        }
    }
    
}

#pragma mark Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    FHAddPinViewController *pinViewController = (FHAddPinViewController *) segue.destinationViewController;
    
    pinViewController.parentParsonalTagController = self;
    pinViewController.title = [[UILabel alloc] init];
    pinViewController.title.text = selectedAnnotation.title;
    pinViewController.desc = [[UILabel alloc] init];
    pinViewController.desc.text = selectedAnnotation.desc;
    pinViewController.categorie = [[UILabel alloc] init];
    pinViewController.categorie.text = selectedAnnotation.type;
    [pinViewController setHidesBottomBarWhenPushed:YES];
    
    NSLog(@"selected Ann when sent: %@",selectedAnnotation.title);
}

@end
