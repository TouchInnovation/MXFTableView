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
@synthesize rightLandscapeHeader = _rightLandscapeHeader;
@synthesize rightPortraitHeader = _rightPortraitHeader;
@synthesize tableView = _tableView;

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame delegate:(id<MXFTableViewDelegate>)delegate
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
        CGRect llhFrame = _leftLandscapeHeader.frame;
        CGFloat llhHeight = llhFrame.size.height;
        CGFloat llhWidth = llhFrame.size.width;
        _rightLandscapeHeader.frame = CGRectMake(llhWidth,
                                                 llhFrame.origin.y,
                                                 480.0 - llhWidth,
                                                 llhFrame.size.height);
        
        CGRect lphFrame = _leftPortraitHeader.frame;
        CGFloat lphWidth = lphFrame.size.width;
        _rightPortraitHeader.frame = CGRectMake(lphWidth,
                                                 lphFrame.origin.y,
                                                 320.0 - llhWidth,
                                                 lphFrame.size.height);
        
        // Assuming view must always init in portrait mode
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, llhHeight, 320.0, 480.0 - llhHeight)];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.dataSource = delegate;
        _tableView.delegate = delegate;
        
        [self addSubview:_leftLandscapeHeader];
        [self addSubview:_leftPortraitHeader];
        [self addSubview:_rightLandscapeHeader];
        [self addSubview:_rightPortraitHeader];
        [self addSubview:_tableView];
    }
    return self;
}

@end
