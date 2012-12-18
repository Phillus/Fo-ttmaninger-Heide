//
//  FHDiashowViewController.m
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 05.12.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import "FHDiashowViewController.h"
#import "FHEntityViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FHEntityTableViewController.h"
#import "FHEntityTableViewController.h"

@interface FHDiashowViewController ()

@end

@implementation FHDiashowViewController

@synthesize pageControl, viewControllers, scrollView, kNumberOfPages, topScrollView, prevPage, imageArray, topViewImageArray;

#define TOP_IMAGE_VIEW_WIDTH @100

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    topViewImageArray = [[NSMutableArray alloc]init];
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    imageArray = [[NSMutableArray alloc] init];
    [imageArray addObject:[UIImage imageNamed:@"IMG_1585.jpg"]];
    [imageArray addObject:[UIImage imageNamed:@"IMG_3311.JPG (1).jpg"]];
    [imageArray addObject:[UIImage imageNamed:@"IMG_3365.JPG"]];
    [imageArray addObject:[UIImage imageNamed:@"IMG_4689.jpg"]];
    [imageArray addObject:[UIImage imageNamed:@"IMG_6857.jpg"]];
    
    // BIG SCROLL VIEW
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(320.0 * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    // TOP SCROLL VIEW
    topScrollView.pagingEnabled = NO;
    topScrollView.contentSize = CGSizeMake(100 * kNumberOfPages, 64.0);
    topScrollView.showsHorizontalScrollIndicator = NO;
    topScrollView.showsVerticalScrollIndicator = NO;
    topScrollView.scrollsToTop = NO;
    topScrollView.delegate = self;
    //topScrollView.contentInset = UIEdgeInsetsMake(0.0, 110, 0.0, 0.0);
    //topScrollView.contentOffset = CGPointMake(110,0);
    
    pageControl.numberOfPages = kNumberOfPages;
    
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [self loadScrollViewWithPage:i];
    }
    pageControl.currentPage = 0;
    
    
}

- (void)infoButtonAction
{
    [self performSegueWithIdentifier:@"showEntityDetail" sender:self];
}


-(void) viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
    
    FHEntityViewController *controller = [self.viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[FHEntityViewController alloc] initWithPageNumber:page:self];
        [self.viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    UIImageView *controllerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [TOP_IMAGE_VIEW_WIDTH doubleValue], 64.0)];
    controllerImageView.contentMode = UIViewContentModeScaleAspectFit;
    controllerImageView.image = [imageArray objectAtIndex:page];
    
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = 320 * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
        
        CGRect imageFrame = controllerImageView.frame;
        imageFrame.origin.x = [TOP_IMAGE_VIEW_WIDTH doubleValue]*page;
        imageFrame.origin.y = 0;
        controllerImageView.frame = imageFrame;
        [topScrollView addSubview:controllerImageView];
        
    }
    
    if([topViewImageArray count]<page+1){
        [topViewImageArray addObject:controllerImageView];
        if(page==0){
            [controllerImageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
            [controllerImageView.layer setBorderWidth: 2.0];
        }
    }
    
    controller.myImage.image = [imageArray objectAtIndex:page];
    
    //bild in top Scroll hinzufügen
}

#pragma mark Scroll view Delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    //NSLog(@"Scroll view did Scroll");
    if (pageControlUsed) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    
    
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"Scroll view did end declarating");
    [self changeTopPage];
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    //NSLog(@"change page to %i",page);
    
    [self changeTopPage];
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControlUsed = YES;
}

-(void)changeTopPage {
    int page = pageControl.currentPage;
    
    
    NSLog(@"change page to %i",page);
    
        CGRect imageFrame = CGRectMake(0,0,100,64);
        NSLog(@"scrollView.origin : %f",scrollView.contentOffset.x);
        
        imageFrame.origin.x = [TOP_IMAGE_VIEW_WIDTH doubleValue]*page;
        imageFrame.origin.y = 0;
        
        NSLog(@"frame.x = %f",imageFrame.origin.x);
    
        [topScrollView setContentOffset:CGPointMake(imageFrame.origin.x,0) animated:YES];
        //[topScrollView scrollRectToVisible:imageFrame animated:YES];
    
    UIImageView *tmpImageView;
    for(int i=0;i<([topViewImageArray count]);i++){
        tmpImageView = (UIImageView *)[topViewImageArray objectAtIndex:i];
        [tmpImageView.layer setBorderWidth: 0.0];
    }
    
    tmpImageView = (UIImageView *)[topViewImageArray objectAtIndex:page];
    [tmpImageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [tmpImageView.layer setBorderWidth: 2.0];
    
    prevPage = page;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FHEntityTableViewController *pinViewController = (FHEntityTableViewController *) segue.destinationViewController;
    
    pinViewController.parentSlideshowController = self;
}

@end
