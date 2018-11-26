//
//  IsInChinaDemoViewController.m
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/4/5.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IsInChinaDemoViewController.h"
#import "MyLocation.h"


@interface IsInChinaDemoViewController()

@property(nonatomic, strong) BMKLocationManager *locationManager;
@property(nonatomic, copy) BMKLocatingCompletionBlock completionBlock;

@end

@implementation IsInChinaDemoViewController

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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"国内外位置判断" message:@"定位的同时，可获取当前定位是属于国内还是国外" preferredStyle:UIAlertControllerStyleAlert];
    
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
    __weak IsInChinaDemoViewController *weakSelf = self;
    self.completionBlock = ^(BMKLocation *location, BMKLocationNetworkState state, NSError *error)
    {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            
        }
        
        if (location.location) {//得到定位信息，添加annotation
            
            NSLog(@"LOC = %@",location.location);
            BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
            
            pointAnnotation.coordinate = location.location.coordinate;
            pointAnnotation.title = @"单次定位";
            if (location.rgcData) {
                pointAnnotation.subtitle = [location.rgcData description];
            } else {
                pointAnnotation.subtitle = @"rgc = null!";
            }
            
            IsInChinaDemoViewController *strongSelf = weakSelf;
            //[strongSelf addAnnotationToMapView:pointAnnotation];
            
            BOOL isInchina = [BMKLocationManager BMKLocationDataAvailableForCoordinate:location.location.coordinate withCoorType:BMKLocationCoordinateTypeBMK09LL];
            NSString * temp = nil;
            if (isInchina) {
                temp = @"在国内";
            } else {
                temp = @"在国外";
            }
            
            [strongSelf updateMessage:[NSString stringWithFormat:@"当前位置信息： \n经纬度：%.6f,%.6f \n国内外判断结果：%@",location.location.coordinate.latitude, location.location.coordinate.longitude, temp]];
            
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
    _locationManager.delegate = nil;
    
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
    _locationManager = nil;
    _completionBlock = nil;
}


- (IBAction)locBtnDown:(id)sender {
    
    [_locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:self.completionBlock];
}


@end
