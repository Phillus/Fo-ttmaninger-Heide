//
//  FHAddPinViewController.m
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 19.11.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import "FHAddPinViewController.h"
#import "FHNewPinCategorieViewController.h"

@interface FHAddPinViewController ()

@end

@implementation FHAddPinViewController

@synthesize title, categorie, desc, categorieView, parentMapController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"title.text = %@",title.text);
    self.navigationItem.hidesBackButton = YES;
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonIsPressed:)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //[self.editButtonItem setAction:@selector(backButtonIsPressed:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Abbrechen" style:UIBarButtonItemStylePlain  target:self action:@selector(abortEditing:)];
}

-(void) abortEditing: (id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backButtonIsPressed:(id)sender{
    if([title.text isEqualToString:@""] || title.text == nil){
        UIAlertView *pleaseFill = [[UIAlertView alloc] initWithTitle:@"Leeres Felde" message:@"Bitte füllen sie das Feld Titel aus" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [pleaseFill show];
    }else{
        [parentMapController updateCurrentAnnotation:title.text :desc.text :categorie.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    UILabel *tmpLabel = [[UILabel alloc] init];
    
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
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    if(indexPath.row == 2){
        return 124;
    }else {
        return 44;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1){
        FHNewPinCategorieViewController *newPinController = [[FHNewPinCategorieViewController alloc] init];
        newPinController.prevController = self;
        [self presentViewController:newPinController animated:YES completion:nil];
    }
}

@end
