//
//  MXFTableViewCell.h
//  MXFTableView
//
//  Created by Jacky Wong on 10/6/12.
//  Copyright (c) 2012 Touch Innovation Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MXFTableViewCellDelegate<NSObject>

@required

- (UIView *)viewForLeftCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)viewForRightLandscapeCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)viewForRightPortraitCellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface MXFTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *leftContent;
@property (strong, nonatomic) UIScrollView *rightContentScrollView;
@property (strong, nonatomic) UIView *rightLandscapeContent;
@property (strong, nonatomic) UIView *rightPortraitContent;

-(void) configureWithDelegate:(id<MXFTableViewCellDelegate>) delegate IndexPath:(NSIndexPath *) indexPath orientation:(UIDeviceOrientation) orientation;
-(void) configureForOrientation:(UIDeviceOrientation) orientation;

@end
