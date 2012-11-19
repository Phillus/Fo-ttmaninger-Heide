//
//  FHAddPinViewController.h
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 19.11.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHAddPinViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *picerDelView;
@property (strong, nonatomic) IBOutlet UIView *picerControllerView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@end
