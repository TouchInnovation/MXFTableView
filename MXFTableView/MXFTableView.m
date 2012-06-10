//
//  MXFTableView.m
//  MXFTableView
//
//  Created by Jacky Wong on 8/6/12.
//  Copyright (c) 2012 Touch Innovation Limited. All rights reserved.
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//  http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "MXFTableView.h"

@implementation MXFTableView

@synthesize leftLandscapeHeader = _leftLandscapeHeader;
@synthesize leftPortraitHeader = _leftPortraitHeader;
@synthesize rightHeaderScrollView = _rightHeaderScrollView;
@synthesize rightLandscapeHeader = _rightLandscapeHeader;
@synthesize rightPortraitHeader = _rightPortraitHeader;
@synthesize tableView = _tableView;

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame delegate:(id<MXFTableViewDelegate, UIScrollViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _delegate = delegate;
        
        _leftLandscapeHeader = [delegate viewForLeftLandscapeHeader];
        _leftPortraitHeader = [delegate viewForLeftPortraitHeader];
        _rightLandscapeHeader = [delegate viewForRightLandscapeHeader];
        _rightPortraitHeader = [delegate viewForRightPortraitHeader];
        
        // Align right headers according to the left header
        // Assuming view must always be initialized in portrait mode
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        CGRect llhFrame = _leftLandscapeHeader.frame;
        CGFloat llhHeight = llhFrame.size.height;
        CGFloat llhWidth = llhFrame.size.width;
        
        _rightHeaderScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(llhWidth,
                                              llhFrame.origin.y,
                                              screenHeight - llhWidth,
                                              llhFrame.size.height)];
        _rightHeaderScrollView.showsHorizontalScrollIndicator = false;
        _rightHeaderScrollView.showsVerticalScrollIndicator = false;
        _rightHeaderScrollView.bounces = false; // Bouncing is NOT supported!!
        _rightHeaderScrollView.delegate = delegate;
        [_rightHeaderScrollView addSubview:_rightLandscapeHeader]; 
        [_rightHeaderScrollView addSubview:_rightPortraitHeader];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, llhHeight, screenWidth, screenHeight - llhHeight)];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.dataSource = delegate;
        _tableView.delegate = delegate;
        
        [self addSubview:_leftLandscapeHeader];
        [self addSubview:_leftPortraitHeader];
        [self addSubview:_rightHeaderScrollView];
        [self addSubview:_tableView];
    }
    return self;
}

@end
