//
//  MXFTableViewCell.m
//  MXFTableView
//
//  Created by Jacky Wong on 10/6/12.
//  Copyright (c) 2012 Touch Innovation Limited. All rights reserved.
//

#import "MXFTableViewCell.h"

@implementation MXFTableViewCell

@synthesize leftContent = _leftContent;
@synthesize rightLandscapeContent = _rightLandscapeContent;
@synthesize rightPortraitContent = _rightPortraitContent;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
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
