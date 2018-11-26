//
//  HotSpotDemoViewController.m
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/4/6.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotSpotDemoViewController.h"


@interface HotSpotDemoViewController()

@property(nonatomic, strong) BMKLocationManager *locationManager;


@end

@implementation HotSpotDemoViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UIBarButtonItem *customRightBarButtonItem = [[UIBarButtonItem alloc] init];
        customRightBarButtonItem.title = @"说明";
        customRightBarButtonItem.action = @selector(showDialoger);
        customRightBarButtonItem.target = self;
        self.navigationItem.rightBarButtonItem = customRightBarButtonItem;
    }
    return self;
}

-(void)showDialoger
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"移动热点识别" message:@"利用百度位置大数据能力，精准判断当前连接wifi信息" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    //    UIAlertAction *action2= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    //
    //    }];
    
    [alert addAction:action1];
    
    // [alert addAction:action2];
    
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    _locationManager.delegate = nil;
    
}
- (void)dealloc {
    _locationManager = nil;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    [locbtn.layer setBorderColor:[UIColor darkTextColor].CGColor];
    [locbtn.layer setBorderWidth:1];
    [locbtn.layer setMasksToBounds:YES];
    [locbtn.layer setCornerRadius:10];

    [self initLocation];
}

-(void)initLocation
{
    _locationManager = [[BMKLocationManager alloc] init];
    
    _locationManager.delegate = self;
    
}

- (IBAction)btnTouchDown:(id)sender {
    [_locationManager requestNetworkState];
}


- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager
     didUpdateNetworkState:(BMKLocationNetworkState)state orError:(NSError * _Nullable)error
{
    NSString * result = nil;
    if (error) {
        result = @"识别结果：当前网络状态无法判断";
    } else {
        switch(state) {
            case BMKLocationNetworkStateWifi:
                result = @"识别结果：当前网络状态是wifi";
                break;
                
            case BMKLocationNetworkStateWifiHotSpot:
                result = @"识别结果：当前网络状态是WIFI移动热点";
                break;
            case BMKLocationNetworkStateMobile4G:
                result = @"识别结果：当前网络状态是4G";
                break;

            case BMKLocationNetworkStateMobile2G:
                result = @"识别结果：当前网络状态是2G";
                break;

            case BMKLocationNetworkStateMobile3G:
                result = @"识别结果：当前网络状态是3G";
                break;

            default:
                result = @"识别结果：当前网络状态无法判断";
                break;
        }
    }
    
    _resultMsg.text = result;
    _resultMsg.numberOfLines = 0;
    
}
@end
