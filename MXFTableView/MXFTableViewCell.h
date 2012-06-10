//
//  MXFTableViewCell.h
//  MXFTableView
//
//  Created by Jacky Wong on 10/6/12.
//  Copyright (c) 2012 Touch Innovation Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXFTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *leftContent;
@property (strong, nonatomic) UIView *rightLandscapeContent;
@property (strong, nonatomic) UIView *rightPortraitContent;

@end
