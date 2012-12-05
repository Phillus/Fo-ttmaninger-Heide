//
//  Annotation.h
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 05.12.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Annotation : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;

@end
