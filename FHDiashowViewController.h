//
//  FHDiashowViewController.h
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 05.12.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHCustonPhotoScrollView.h"

@interface FHDiashowViewController : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIScrollView *topScrollView;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    BOOL pageControlUsed;
    BOOL topPageControlUsed;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIScrollView *topScrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic) int kNumberOfPages;
@property (nonatomic) int prevPage;
- (IBAction)changePage:(id)sender;
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) NSMutableArray *topViewImageArray;
-(void) infoButtonAction;

@end
