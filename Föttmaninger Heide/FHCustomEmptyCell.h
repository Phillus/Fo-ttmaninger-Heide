//
//  FHCustomEmptyCell.h
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 18.12.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FHCustomEmptyCell : UITableViewCell

@property (strong, nonatomic) IBOutlet MKMapView *myMap;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end
