//
//  MXFTableViewController.h
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

#import <UIKit/UIKit.h>
#import "MXFTableView.h"
#import "MXFTableViewCell.h"

@interface MXFTableViewController : UIViewController<MXFTableViewDelegate, MXFTableViewCellDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) MXFTableView *mxfTableView;

@end
