//
//  MXFTableViewController.m
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

#import "MXFTableViewController.h"

#define kRowHeight 40.0

@interface MXFTableViewController ()

@end

@implementation MXFTableViewController

@synthesize mxfTableView = _mxfTableView;


# pragma mark - View Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _mxfTableView = [[MXFTableView alloc] initWithFrame:self.view.frame delegate:self];
        self.view = _mxfTableView;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


# pragma mark - MXFTableViewDelegate methods

-(UIView*) viewForLeftLandscapeHeader {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
    view.backgroundColor = [UIColor blueColor];
    return view;
}

-(UIView*) viewForLeftPortraitHeader {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
    view.backgroundColor = [UIColor greenColor];
    return view;
}

-(UIView*) viewForRightLandscapeHeader {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor purpleColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"RL Header";
    [view addSubview:label];
    return view;    
}

-(UIView*) viewForRightPortraitHeader {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"RP Header";
    [view addSubview:label];
    return view;
}

- (UIView *)viewForLeftCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, kRowHeight)];
    view.backgroundColor = [UIColor magentaColor];
    return view;
}

- (UIView *)viewForRightLandscapeCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)viewForRightPortraitCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;    
}


# pragma mark - UITableViewDataSource Methods:

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // To be implemented by subclass
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath");
    static NSString *CellIdentifier = @"MXFTableViewCell";
    
    MXFTableViewCell *cell = (MXFTableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[MXFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"Row: %d", indexPath.row];
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    [cell configureWithDelegate:self IndexPath:indexPath orientation:orientation];
    
    return cell;
}


# pragma mark - UITableViewDelegate Methods:

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}


# pragma mark - Orientation related methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return true;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if(UIDeviceOrientationIsLandscape(toInterfaceOrientation)) {
        _mxfTableView.leftLandscapeHeader.hidden = false;
        _mxfTableView.rightLandscapeHeader.hidden = false;
        _mxfTableView.leftPortraitHeader.hidden = true;
        _mxfTableView.rightPortraitHeader.hidden = true;
    } else {
        _mxfTableView.leftPortraitHeader.hidden = false;
        _mxfTableView.rightPortraitHeader.hidden = false;
        _mxfTableView.leftLandscapeHeader.hidden = true;
        _mxfTableView.rightLandscapeHeader.hidden = true;
    }
}

@end
