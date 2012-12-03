//
//  FHCategoriesViewController.m
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 06.11.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import "FHCategoriesViewController.h"

@interface FHCategoriesViewController ()

@end

@implementation FHCategoriesViewController

@synthesize categoriesArray, statusArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIBarButtonItem *_backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = _backButton;
    
    statusArray = [[NSMutableArray alloc] init];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    NSArray *topLevel = [NSArray arrayWithObjects:@"Alle",@"Pflanzen",@"Tiere", nil];
    
    NSArray *pflanzenLayer = [NSArray arrayWithObjects:@"Rot",@"Grün",@"Blau", nil];
    NSDictionary *pflanzenDict = [NSDictionary dictionaryWithObjects:pflanzenLayer forKeys:pflanzenLayer];
    
    NSArray *tiereLayer = [NSArray arrayWithObjects:@"Insekten",@"Vögel",@"Säugetiere", @"Reptilien", nil];
    NSDictionary *tiereDict = [NSDictionary dictionaryWithObjects:tiereLayer forKeys:tiereLayer];
    
    NSMutableArray *firstLayer = [[NSMutableArray alloc] init];
    NSArray *searchResultArr = [[NSArray alloc] initWithObjects:@"suchergebnis", nil];
    NSDictionary *searchResultDict = [NSDictionary dictionaryWithObjects:searchResultArr forKeys:searchResultArr];
    [firstLayer insertObject:searchResultDict atIndex:[firstLayer count]];
    [firstLayer insertObject:pflanzenDict atIndex:[firstLayer count]];
    [firstLayer insertObject:tiereDict atIndex:[firstLayer count]];
    
    categoriesArray = [[NSDictionary alloc]init];
    categoriesArray = [NSDictionary dictionaryWithObjects:firstLayer forKeys:topLevel];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSDictionary *tmpDic = categoriesArray;
    BOOL isEmpty = YES;
    int countDepth = 0;
    for(NSString *status in statusArray){
        tmpDic = (NSDictionary *)[tmpDic objectForKey:status];
        countDepth++;
        if([status isEqualToString:[tmpDic description]]){
            isEmpty = YES;
        }else{
            isEmpty = NO;
        }
    }
    
    if(isEmpty == YES && [statusArray count]>0){
        return 2; // SUCHERGEBNIS ANZEIGEN
    }else {
        if(!isEmpty){
            NSLog(@"allKeys %@",[[tmpDic allKeys]sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]);
            return [tmpDic count]+1; // Ohne BACK Button
        }else{
            NSLog(@"allKeys %@",[[tmpDic allKeys]sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]);
            return [tmpDic count]; // Mit BACK Button
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tmpDic = categoriesArray;
    BOOL isEmpty = YES;
    int countDepth = 0;
    for(NSString *status in statusArray){
        tmpDic = (NSDictionary *)[tmpDic objectForKey:status];
        countDepth++;
        if([status isEqualToString:[tmpDic description]]){
            isEmpty = YES;
        }else{
            isEmpty = NO;
        }
    }
    
    if((indexPath.row == 0 && !isEmpty) || (isEmpty == YES && [statusArray count]>0 && indexPath.row==0)){
        static NSString *CellIdentifier = @"backCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = @"Back";
                
        return cell;
    }else {
        static NSString *CellIdentifier = @"categoriesCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if(isEmpty == NO && [statusArray count]>0){
            cell.textLabel.text = [[[tmpDic allKeys]sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.row-1];
        }else if(isEmpty == YES && [statusArray count]==0){
            cell.textLabel.text = [[[tmpDic allKeys]sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.row];
        }
        else{
            cell.textLabel.text = @"Ergebnisse";
        }
        
        return cell;
    }
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

- (BOOL) checkStatusArray {
    NSDictionary *tmpDic = categoriesArray;
    BOOL isEmpty = YES;
    int countDepth = 0;
    for(NSString *status in statusArray){
        tmpDic = (NSDictionary *)[tmpDic objectForKey:status];
        countDepth++;
        if([status isEqualToString:[tmpDic description]]){
            isEmpty = YES;
        }else{
            isEmpty = NO;
        }
    }
    return isEmpty;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    BOOL isEmpty = [self checkStatusArray];
    
    if(indexPath.row==0 && [selectedCell.textLabel.text isEqualToString:@"Back"]){
        [self returnToPrev];
    }else if(isEmpty == YES && [statusArray count]>0){
        [self performSegueWithIdentifier:@"showSearchResultEntity" sender:self]; // SUCHERGEBNIS ANZEIGEN
    }
    else{
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        [statusArray insertObject:selectedCell.textLabel.text atIndex:[statusArray count]];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (void)returnToPrev {
    [statusArray removeObjectAtIndex:[statusArray count]-1];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
}
@end
