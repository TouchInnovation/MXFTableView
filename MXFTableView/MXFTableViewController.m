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

#define kDemoRowCount 20
#define kDemoRowHeight 40.0

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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, kDemoRowHeight)];
    view.backgroundColor = [UIColor blueColor];
    return view;
}

-(UIView*) viewForLeftPortraitHeader {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, kDemoRowHeight)];
    view.backgroundColor = [UIColor greenColor];
    return view;
}

-(UIView*) viewForRightLandscapeHeader {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 800.0, kDemoRowHeight)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 800.0, kDemoRowHeight)];
    label.text = @"LANDSCAPE HEADER LANDSCAPE HEADER LANDSCAPE HEADER LANDSCAPE HEADER LANDSCAPE HEADER LANDSCAPE HEADER LANDSCAPE HEADER LANDSCAPE HEADER LANDSCAPE HEADER ";
    [view addSubview:label];
    return view;
}

-(UIView*) viewForRightPortraitHeader {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, kDemoRowHeight)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, kDemoRowHeight)];
    label.text = @"PORTRAIT HEADER";
    [view addSubview:label];
    return view;
}

- (UIView *)viewForLeftCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, kDemoRowHeight)];
    view.backgroundColor = [UIColor magentaColor];
    return view;
}

- (UIView *)viewForRightLandscapeCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 800.0, kDemoRowHeight)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 800.0, kDemoRowHeight)];
    label.text = @"LANDSCAPE cell LANDSCAPE cell LANDSCAPE cell LANDSCAPE cell LANDSCAPE cell LANDSCAPE cell LANDSCAPE cell LANDSCAPE cell LANDSCAPE cell LANDSCAPE cell ";
    [view addSubview:label];
    return view;
}

- (UIView *)viewForRightPortraitCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, kDemoRowHeight)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, kDemoRowHeight)];
    label.text = @"PORTRAIT cell";
    [view addSubview:label];
    return view;
}


# pragma mark - UITableViewDataSource Methods:

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // To be implemented by subclass
    return kDemoRowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MXFTableViewCell";
    
    MXFTableViewCell *cell = (MXFTableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[MXFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.rightContentScrollView.delegate = self;
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"Row: %d", indexPath.row];
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    [cell configureWithDelegate:self IndexPath:indexPath orientation:orientation];
    
    return cell;
}


# pragma mark - UITableViewDelegate Methods:

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kDemoRowHeight;
}


# pragma mark - Orientation related methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return true;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    // Configure header for the new orientation
    if(UIDeviceOrientationIsLandscape(toInterfaceOrientation)) {
        _mxfTableView.leftLandscapeHeader.hidden = false;
        _mxfTableView.rightLandscapeHeader.hidden = false;
        _mxfTableView.leftPortraitHeader.hidden = true;
        _mxfTableView.rightPortraitHeader.hidden = true;
        
        _mxfTableView.rightHeaderScrollView.contentSize = _mxfTableView.rightLandscapeHeader.frame.size;
    } else {
        _mxfTableView.leftPortraitHeader.hidden = false;
        _mxfTableView.rightPortraitHeader.hidden = false;
        _mxfTableView.leftLandscapeHeader.hidden = true;
        _mxfTableView.rightLandscapeHeader.hidden = true;
        _mxfTableView.rightHeaderScrollView.contentSize = _mxfTableView.rightPortraitHeader.frame.size;
    }
}

- (void) willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {    
    // Configure table cell for the new orientation
    NSArray *visiblePaths = [_mxfTableView.tableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in visiblePaths)
    {
        MXFTableViewCell *cell = (MXFTableViewCell*) [_mxfTableView.tableView cellForRowAtIndexPath:indexPath];
        [cell configureForOrientation:[[UIDevice currentDevice] orientation]];
    }
}


# pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)currentScrollView{

    CGPoint offset = [currentScrollView contentOffset];

    if(offset.y == 0) { // Lock vertical scrolling
        
        if(currentScrollView == _mxfTableView.rightHeaderScrollView) {
//            NSLog(@"Skip as same header view");
        } else {            
            // Adjust header offset
            [_mxfTableView.rightHeaderScrollView setContentOffset:offset];
        }
        
        // Adjust content cell offset
        NSArray *visiblePaths = [_mxfTableView.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths) {
            MXFTableViewCell *cell = (MXFTableViewCell*) [_mxfTableView.tableView cellForRowAtIndexPath:indexPath];
            UIScrollView *scrollView = cell.rightContentScrollView;
            if(scrollView == currentScrollView) {
//                NSLog(@"Skip as same scrollview");
            } else {
                [scrollView setContentOffset:offset animated:false];
            }
        }
    }
}

@end
