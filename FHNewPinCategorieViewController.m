//
//  FHNewPinCategorieViewController.m
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 26.11.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import "FHNewPinCategorieViewController.h"
#import "FHAddPinViewController.h"

@interface FHNewPinCategorieViewController ()

@end

@implementation FHNewPinCategorieViewController

@synthesize catArr, prevController, colorArr, prevEntityController;

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

    catArr = [[NSMutableArray alloc] init];
    [catArr addObject:@"Tier"];
    [catArr addObject:@"Pflanze"];
    [catArr addObject:@"Alle"];
    
    colorArr = [[NSMutableArray alloc] init];
    [colorArr addObject:[[UIColor yellowColor] colorWithAlphaComponent:0.4]];
    [colorArr addObject:[[UIColor greenColor] colorWithAlphaComponent:0.4]];
    [colorArr addObject:[[UIColor blueColor] colorWithAlphaComponent:0.4]];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [catArr objectAtIndex:indexPath.row];
    cell.backgroundColor = [colorArr objectAtIndex:indexPath.row];
    cell.textLabel.backgroundColor = [UIColor clearColor
                                      ];
    
    return cell;
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
    UITableViewCell *tmpCell = [[UITableViewCell alloc] init];
    for(int i = 0;i <= [tableView numberOfRowsInSection:0];i++){
        tmpCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        if(i != indexPath.row){
            tmpCell.accessoryType = UITableViewCellAccessoryNone;
        }else {
            tmpCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if(prevController){
        prevController.categorie.text = selectedCell.textLabel.text;
        prevController.categorieView.backgroundColor = selectedCell.backgroundColor;
    }else{
        prevEntityController.categorie.text = selectedCell.textLabel.text;
        prevEntityController.categorieView.backgroundColor = selectedCell.backgroundColor;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
