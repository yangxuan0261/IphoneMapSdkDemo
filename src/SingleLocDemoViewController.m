//
//  SingleLocDemoViewController.m
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/4/5.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleLocDemoViewController.h"
#import "MyLocation.h"


@interface SingleLocDemoViewController()

@property(nonatomic, strong) BMKLocationManager *locationManager;
@property(nonatomic, assign) BOOL isNeedAddr;
@property(nonatomic, assign) BOOL isNeedHotSpot;
@property(nonatomic, copy) BMKLocatingCompletionBlock completionBlock;

@end

@implementation SingleLocDemoViewController

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
    _isNeedAddr = YES;
    _isNeedHotSpot = YES;
    
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![locMessage isExclusiveTouch]) {
        [locMessage resignFirstResponder];
    }
}

/**
 *点中底图标注后会回调此接口
 *@param mapview 地图View
 *@param mapPoi 标注点信息
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    
    if (![locMessage isExclusiveTouch]) {
        [locMessage resignFirstResponder];
    }
}

/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    
    if (![locMessage isExclusiveTouch]) {
        [locMessage resignFirstResponder];
    }
}



-(void)showDialoger
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"单次定位" message:@"对系统定位进行了封装，同时可返回地址信息和网络状态信息" preferredStyle:UIAlertControllerStyleAlert];
    
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

-(void)initLocation
{
    _locationManager = [[BMKLocationManager alloc] init];
    
    _locationManager.delegate = self;
    
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    _locationManager.allowsBackgroundLocationUpdates = YES;
    _locationManager.locationTimeout = 10;
    _locationManager.reGeocodeTimeout = 10;
    
}

-(void)initBlock
{
    __weak SingleLocDemoViewController *weakSelf = self;
    self.completionBlock = ^(BMKLocation *location, BMKLocationNetworkState state, NSError *error)
    {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            
        }
        
        if (location.location) {//得到定位信息，添加annotation
        
            NSLog(@"LOC = %@",location.location);
            NSLog(@"LOC ID= %@",location.locationID);
            BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
            
            pointAnnotation.coordinate = location.location.coordinate;
            pointAnnotation.title = @"单次定位";
            if (location.rgcData) {
                pointAnnotation.subtitle = [location.rgcData description];
            } else {
                pointAnnotation.subtitle = @"rgc = null!";
            }
            
            SingleLocDemoViewController *strongSelf = weakSelf;
            
            [strongSelf updateMessage:[NSString stringWithFormat:@"当前位置信息： \n经纬度：%.6f,%.6f \n地址信息：%@ \n网络状态：%d",location.location.coordinate.latitude, location.location.coordinate.longitude, [location.rgcData description], state]];
            
            //[_mapView a];
            MyLocation * loc = [[MyLocation alloc]initWithLocation:location.location withHeading:nil];
            [strongSelf addLocToMapView:loc];
            
        }
        
        if (location.rgcData) {
            NSLog(@"rgc = %@",[location.rgcData description]);
        }
        
        NSLog(@"netstate = %d",state);
    };
    
    
}

-(void)updateMessage:(NSString *)msg
{
    locMessage.text = msg;
    
}

- (void)addLocToMapView:(MyLocation *)loc
{
    [_mapView updateLocationData:loc];
    [_mapView setCenterCoordinate:loc.location.coordinate animated:YES];
}

- (void)addAnnotationToMapView:(BMKPointAnnotation *)annotation
{
    [_mapView addAnnotation:annotation];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }

    [self initBlock];
    [self initLocation];
    locMessage.text = @"定位信息：";

    [locbtn.layer setBorderColor:[UIColor darkTextColor].CGColor];
    [locbtn.layer setBorderWidth:1];
    [locbtn.layer setMasksToBounds:YES];
    [locbtn.layer setCornerRadius:10];
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _mapView.showsUserLocation = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [_locationManager stopUpdatingLocation];
    _locationManager.delegate = nil;
    
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
    _locationManager = nil;
    _completionBlock = nil;
}

- (IBAction)addrSwitchValueChange:(id)sender {
    
    UISwitch *switchControl = (UISwitch*)sender;
    _isNeedAddr = switchControl.isOn;
}

- (IBAction)locBtnTouch:(id)sender {
    
    [_locationManager requestLocationWithReGeocode:_isNeedAddr withNetworkState:_isNeedHotSpot completionBlock:self.completionBlock];
}

- (IBAction)hotspotValueChanged:(id)sender {
    UISwitch *switchControl = (UISwitch*)sender;
    _isNeedHotSpot = switchControl.isOn;
}


@end
