//
//  SerialLocDemoViewController.m
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/4/7.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SerialLocDemoViewController.h"
#import "MyLocation.h"


@interface SerialLocDemoViewController()

@property(nonatomic, strong) BMKLocationManager *locationManager;
@property(nonatomic, assign) BOOL isNeedAddr;
@property(nonatomic, assign) BOOL isLocationg;
@property(nonatomic, assign) int locnum;
@property(nonatomic, assign) CLLocationDirection dir;
@property(nonatomic, assign) CLLocationDirection dir222;
@property(nonatomic, assign) CLLocationDistance distanceConfig;

@end

@implementation SerialLocDemoViewController
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
    _isLocationg = NO;
    _distanceConfig = kCLDistanceFilterNone;
    _locnum = 0;
    
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![locMessage isExclusiveTouch]) {
        [locMessage resignFirstResponder];
    }
    
    if (![distance isExclusiveTouch]) {
        [distance resignFirstResponder];
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
    if (![distance isExclusiveTouch]) {
        [distance resignFirstResponder];
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
    if (![distance isExclusiveTouch]) {
        [distance resignFirstResponder];
    }
}


-(void)showDialoger
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"连续定位" message:@"采用了系统定位，同时扩展了地址信息返回功能" preferredStyle:UIAlertControllerStyleAlert];
    
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
    _locationManager.distanceFilter = [distance.text doubleValue];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    _locationManager.allowsBackgroundLocationUpdates = NO;// YES的话是可以进行后台定位的，但需要项目配置，否则会报错，具体参考开发文档
    _locationManager.locationTimeout = 10;
    _locationManager.reGeocodeTimeout = 10;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    distance.text = @"10";
    [self initLocation];
    locMessage.text = @"连续定位信息：";
    [locBtn.layer setBorderColor:[UIColor darkTextColor].CGColor];
    [locBtn.layer setBorderWidth:1];
    [locBtn.layer setMasksToBounds:YES];
    [locBtn.layer setCornerRadius:10];
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
    [_locationManager stopUpdatingHeading];
    _locationManager.delegate = nil;
    
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
    _locationManager = nil;
}


/**
 *  @brief 当定位发生错误时，会调用代理的此方法。
 *  @param manager 定位 BMKLocationManager 类。
 *  @param error 返回的错误，参考 CLError 。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nullable)error
{

    NSLog(@"serial loc error = %@", error);

}


- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didUpdateLocation:(BMKLocation * _Nullable)location orError:(NSError * _Nullable)error

{


    if (error)
    {
        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        
        
    } if (location) {//得到定位信息，添加annotation
        if (location.location) {
            NSLog(@"LOC = %@",location.location);
        }
        BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
        
        pointAnnotation.coordinate = location.location.coordinate;
        pointAnnotation.title = @"连续定位";
        if (location.rgcData) {
            pointAnnotation.subtitle = [location.rgcData description];
        } else {
            pointAnnotation.subtitle = @"rgc = null!";
        }
        
        
        [self addAnnotationToMapView:pointAnnotation];
        
        MyLocation * loc = [[MyLocation alloc]initWithLocation:location.location withHeading:nil];
        [self addLocToMapView:loc];
        
        [self updateMessage:[NSString stringWithFormat:@"lat=%.6f|lon=%.6f|dir=%.6f|dir222=%.6f",location.location.coordinate.latitude, location.location.coordinate.longitude, _dir, _dir222]];
        
    }

    

}

- (void)addLocToMapView:(MyLocation *)loc
{
    [_mapView updateLocationData:loc];
    [_mapView setCenterCoordinate:loc.location.coordinate animated:YES];
}

/**
 *  @brief 定位权限状态改变时回调函数
 *  @param manager 定位 BMKLocationManager 类。
 *  @param status 定位权限状态。
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{

 
    NSLog(@"serial loc CLAuthorizationStatus = %d", status);

}



/**
 * BMKLocationManagerShouldDisplayHeadingCalibration:
 *    该方法为BMKLocationManager提示需要设备校正回调方法。
 * @param manager 提供该定位结果的BMKLocationManager类的实例
 */
- (BOOL)BMKLocationManagerShouldDisplayHeadingCalibration:(BMKLocationManager * _Nonnull)manager
{


    NSLog(@"serial loc need calibration heading! ");
    return YES;
}

/**
 * BMKLocationManager:didUpdateHeading:
 *    该方法为BMKLocationManager提供设备朝向的回调方法。
 * @param manager 提供该定位结果的BMKLocationManager类的实例
 * @param heading 设备的朝向结果
 */
- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager
          didUpdateHeading:(CLHeading * _Nullable)heading
{

    _dir = heading.magneticHeading;
    _dir222 = heading.trueHeading;

    NSLog(@"serial loc heading = %@", heading.description);

}


-(void)updateMessage:(NSString *)msg
{
    _locnum++;
    locMessage.text = [NSString stringWithFormat:@"%@ \nlocation%d:%@", locMessage.text,_locnum,msg];
}

- (void)addAnnotationToMapView:(BMKPointAnnotation *)annotation
{
    [_mapView addAnnotation:annotation];
}

- (IBAction)locBtnDown:(id)sender {
    if (_isLocationg) {
        [_locationManager stopUpdatingLocation];
        if ([BMKLocationManager headingAvailable]) {
            [_locationManager stopUpdatingHeading];
        }
        [locBtn setTitle:@"开始连续定位" forState:UIControlStateNormal];
        _isLocationg = NO;
    } else {
        _locationManager.locatingWithReGeocode = _isNeedAddr;
        [_locationManager startUpdatingLocation];
        if ([BMKLocationManager headingAvailable]) {
            [_locationManager startUpdatingHeading];
        }
        [locBtn setTitle:@"停止连续定位" forState:UIControlStateNormal];
        _isLocationg = YES;
        
    }
}

- (IBAction)switchValueChanged:(id)sender {
    UISwitch *switchControl = (UISwitch*)sender;
    _isNeedAddr = switchControl.isOn;
}


@end
