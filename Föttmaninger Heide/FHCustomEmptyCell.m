//
//  FHCustomEmptyCell.m
//  Föttmaninger Heide
//
//  Created by Philipp Sporrer on 18.12.12.
//  Copyright (c) 2012 Philipp Sporrer. All rights reserved.
//

#import "FHCustomEmptyCell.h"

@implementation FHCustomEmptyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
