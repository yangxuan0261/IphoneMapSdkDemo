//
//  AppDelegate.m
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-3-21.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "AppDelegate.h"


BMKMapManager* _mapManager;
@implementation AppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
	// 要使用百度地图，请先启动BaiduMapManager
	_mapManager = [[BMKMapManager alloc]init];
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:@"Gim7dQ8hNycR0j4Uj2BdZUOZBZtBWshd" authDelegate:self];
    BOOL ret = [_mapManager start:@"Gim7dQ8hNycR0j4Uj2BdZUOZBZtBWshd" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    
    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"--- onGetPermissionState %d",iError);
    }
}

- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError
{
    NSLog(@"--- location auth onGetPermissionState %ld",(long)iError);
    
}

@end
