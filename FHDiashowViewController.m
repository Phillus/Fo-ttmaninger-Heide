//
//  FHDiashowViewController.m
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 05.12.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import "FHDiashowViewController.h"
#import "FHEntityViewController.h"

@interface FHDiashowViewController ()

@end

@implementation FHDiashowViewController

@synthesize pageControl, viewControllers, scrollView, kNumberOfPages, topScrollView, prevPage, imageArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    //topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,320,66)];
    topScrollView.pagingEnabled = NO;
    topScrollView.contentSize = CGSizeMake(320.0 * kNumberOfPages, 64.0);
    topScrollView.showsHorizontalScrollIndicator = NO;
    topScrollView.showsVerticalScrollIndicator = NO;
    topScrollView.scrollsToTop = NO;
    topScrollView.delegate = self;
    
    pageControl.numberOfPages = kNumberOfPages;
    
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [self loadScrollViewWithPage:i];
    }
    
    pageControl.currentPage = 0;
}

-(void) viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
    
    FHEntityViewController *controller = [self.viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[FHEntityViewController alloc] initWithPageNumber:page];
        [self.viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    UIImageView *controllerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 64.0)];
    controllerImageView.contentMode = UIViewContentModeScaleAspectFit;
    controllerImageView.image = [imageArray objectAtIndex:page];
    
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = 320 * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
        
        if(page==0){
            CGRect imageFrame = controllerImageView.frame;
            imageFrame.origin.x = (320/2)-(controllerImageView.frame.size.width /2);
            imageFrame.origin.y = 0;
            controllerImageView.frame = imageFrame;
            [topScrollView addSubview:controllerImageView];
        }else {
            CGRect imageFrame = controllerImageView.frame;
            imageFrame.origin.x = ((320/2)+(controllerImageView.frame.size.width /2)+10) + ((page-1)*(controllerImageView.frame.size.width +10));
            imageFrame.origin.y = 0;
            controllerImageView.frame = imageFrame;
            [topScrollView addSubview:controllerImageView];
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
    
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
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
    //für top scroll scrollrecttovisible ausführen
    if(page==0){
        CGRect imageFrame = CGRectMake(0,0,100,66);
        imageFrame.origin.x = (320/2)-(imageFrame.size.width /2);
        imageFrame.origin.y = 0;
        imageFrame.origin.x = imageFrame.origin.x - ((320/2)-(imageFrame.size.width /2));
        [topScrollView scrollRectToVisible:imageFrame animated:YES];
    }else {
        CGRect imageFrame = CGRectMake(0,0,100,66);
        imageFrame.origin.x = ((320/2)+(imageFrame.size.width /2)+10) + ((page-1)*(imageFrame.size.width +10));
        imageFrame.origin.y = 0;
        if(page>prevPage){
            imageFrame.origin.x = imageFrame.origin.x + (320/2)-(imageFrame.size.width /2);
        }else {
            imageFrame.origin.x = imageFrame.origin.x - ((320/2)-(imageFrame.size.width /2));

        }
        NSLog(@"frame.x = %f",imageFrame.origin.x);
        [topScrollView scrollRectToVisible:imageFrame animated:YES];
    }
    
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

@end
