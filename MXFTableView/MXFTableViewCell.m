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
@synthesize rightScrollView = _rightScrollView;
@synthesize rightLandscapeContent = _rightLandscapeContent;
@synthesize rightPortraitContent = _rightPortraitContent;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _rightScrollView = [[UIScrollView alloc] init];
        _rightScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _rightScrollView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_rightScrollView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) configureWithDelegate:(id<MXFTableViewCellDelegate>) delegate IndexPath:(NSIndexPath *) indexPath orientation:(UIDeviceOrientation) orientation {
    // Configure left content view
    self.leftContent = [delegate viewForLeftCellForRowAtIndexPath:indexPath];
    [self addSubview:_leftContent];
    
    // Configure right scroll view
    CGSize leftContentSize = _leftContent.frame.size;
    _rightScrollView.frame = CGRectMake(leftContentSize.width,
                                        0.0,
                                        self.frame.size.width - leftContentSize.width,
                                        leftContentSize.height);
    
    // Remove previous content views
    [_rightLandscapeContent removeFromSuperview]; 
    [_rightPortraitContent removeFromSuperview]; 
    
    // Construct new content view
    _rightLandscapeContent = [delegate viewForRightLandscapeCellForRowAtIndexPath:indexPath];
    _rightPortraitContent = [delegate viewForRightPortraitCellForRowAtIndexPath:indexPath];
    [_rightScrollView addSubview:_rightLandscapeContent];
    [_rightScrollView addSubview:_rightPortraitContent];
    
    [self configureForOrientation:orientation];
}

- (void)configureForOrientation:(UIDeviceOrientation)orientation {
    if(UIDeviceOrientationIsLandscape(orientation)) {
        _rightLandscapeContent.hidden = false;
        _rightPortraitContent.hidden = true;
    } else {
        _rightLandscapeContent.hidden = true;
        _rightPortraitContent.hidden = false;
    }
}

@end
