//
//  FHEntityViewController.h
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 05.12.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHEntityViewController : UIViewController{
    IBOutlet UILabel *pageNumberLabel;
    IBOutlet UIImageView *myImage;
    int pageNumber;
}
@property (nonatomic, retain) UILabel *pageNumberLabel;
@property (nonatomic, retain) IBOutlet UIImageView *myImage;
- (id)initWithPageNumber:(int)page;

@end
