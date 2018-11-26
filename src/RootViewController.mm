//
//  ViewController.m
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-3-21.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "RootViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _demoNameArray = [[NSArray alloc]initWithObjects:
                      @"单次定位功能",
                      @"连续定位功能",
                      @"后台连续定位功能",
                      @"圆形地理围栏功能",
                      @"多边形地理围栏功能",
                      @"移动热点识别功能",
                      @"国内外判断功能",
                      nil];
    _viewControllerTitleArray = [[NSArray alloc]initWithObjects:
                                 @"单次定位功能",
                                 @"连续定位功能",
                                 @"后台连续定位功能",
                                 @"圆形地理围栏功能",
                                 @"多边形地理围栏功能",
                                 @"移动热点识别功能",
                                 @"国内外判断功能",
                                 nil];
    
    _viewControllerArray = [[NSArray alloc]initWithObjects:
                            @"SingleLocDemoViewController",
                            @"SerialLocDemoViewController",
                            @"BackgroundLocDemoViewController",
                            @"CircleGeofenceDemoViewController",
                            @"PolyGonGeofenceDemoViewController",
                            @"HotSpotDemoViewController",
                            @"IsInChinaDemoViewController",
                            nil];
    self.title = @"欢迎使用百度定位iOS SDK";
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
}

#pragma mark -
#pragma mark Table view data source


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _demoNameArray.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"BaiduMapApiDemoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [_demoNameArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [_viewControllerArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.numberOfLines=9999;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 57.0f;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController* viewController = nil;
    if (indexPath.row < 19 && indexPath.row != 12) {
        viewController = [[NSClassFromString([_viewControllerArray objectAtIndex:indexPath.row]) alloc] init];
    } else {
        viewController = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:[_viewControllerArray objectAtIndex:indexPath.row]];
    }
    viewController.title = [_viewControllerTitleArray objectAtIndex:indexPath.row];
    UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] init];
    customLeftBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = customLeftBarButtonItem;
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

@end
