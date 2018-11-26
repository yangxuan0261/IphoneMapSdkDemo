//
//  CircleGeofenceDemoViewController.m
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/4/7.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CircleGeofenceDemoViewController.h"

@interface CircleGeofenceDemoViewController()

@property(nonatomic, strong) BMKGeoFenceManager *geofenceManager;

@property(nonatomic,assign)CLLocationCoordinate2D centerGeofence;

@property (nonatomic,assign)int btnStatus;
@end

@implementation CircleGeofenceDemoViewController


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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"圆形地理围栏" message:@"围栏使用过程：1、长按地图设置中心点 2、设置围栏半径  3、点击创建围栏  4、开始监听  5、停止监听" preferredStyle:UIAlertControllerStyleAlert];
    
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

-(void)initGeofence
{
    
    _geofenceManager = [[BMKGeoFenceManager alloc] init];
    _geofenceManager.delegate = self;
    
    _geofenceManager.pausesLocationUpdatesAutomatically = NO;
    _geofenceManager.allowsBackgroundLocationUpdates = YES;
    
    _centerGeofence =  CLLocationCoordinate2DMake(39.914682, 116.403898); //天安门
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
    
    pointAnnotation.coordinate = _centerGeofence;
    pointAnnotation.title = @"圆形地理围栏";
    [_mapView removeAnnotations:_mapView.annotations];
    
    [_mapView addAnnotation:pointAnnotation];
    _geofenceManager.activeAction = BMKGeoFenceActiveActionStayed | BMKGeoFenceActiveActionInside | BMKGeoFenceActiveActionOutside;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    geofenceRadius.text = @"100";
    _btnStatus = 0;
    [self initGeofence];
    [geofenceBtn.layer setBorderColor:[UIColor darkTextColor].CGColor];
    [geofenceBtn.layer setBorderWidth:1];
    [geofenceBtn.layer setMasksToBounds:YES];
    [geofenceBtn.layer setCornerRadius:10];
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
    
    [_geofenceManager removeAllGeoFenceRegions];
    _geofenceManager.delegate = nil;
    
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
    _geofenceManager = nil;
}


// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //普通annotation
    
    NSString *AnnotationViewID = @"renameMark";
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 设置颜色
        annotationView.pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
        annotationView.animatesDrop = YES;
        // 设置可拖拽
        annotationView.draggable = YES;
    }
    return annotationView;
    
    
}


//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKCircle class]])
    {
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:0.1];
        circleView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.5];
        circleView.lineWidth = 2.0;
        
        return circleView;
    }
    
    
    return nil;
}

/**
 *长按地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回长按事件坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"onLongClick-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    NSString* showmeg = [NSString stringWithFormat:@"您长按了地图(long pressed).\r\n当前经度:%f,当前纬度:%f", coordinate.longitude,coordinate.latitude];
    geofenceMsg.text = showmeg;
    geofenceMsg.numberOfLines = 0;
    _centerGeofence = coordinate;
    
    BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
    
    pointAnnotation.coordinate = coordinate;
    pointAnnotation.title = @"圆形地理围栏";
    [_mapView removeAnnotations:_mapView.annotations];
    
    [_mapView addAnnotation:pointAnnotation];
    
}

- (IBAction)geofenceBtntrigger:(id)sender {
    _btnStatus++;
    
    if (_btnStatus == 1) {
        [geofenceBtn setTitle:@"开启围栏状态监听" forState:UIControlStateNormal];
        
        
        BMKCircle* circle = [BMKCircle circleWithCenterCoordinate:_centerGeofence  radius:[geofenceRadius.text integerValue]];
        
        [_mapView addOverlay:circle];
        geofenceMsg.text = @"设置地理围栏完成！";
        
    } else if(_btnStatus == 2) {
        [geofenceBtn setTitle:@"停止围栏状态监听" forState:UIControlStateNormal];
        
        [_geofenceManager addCircleRegionForMonitoringWithCenter:_centerGeofence radius:[geofenceRadius.text integerValue] coorType:BMKLocationCoordinateTypeBMK09LL customID:@"circle_1"];
        // geofenceMsg.text = @"地理围栏状态：";
        
    } else {
        
        [_mapView removeOverlays:_mapView.overlays];
        [_mapView removeAnnotations:_mapView.annotations];
        
        [_geofenceManager removeAllGeoFenceRegions];
        [geofenceBtn setTitle:@"点击完成围栏创建" forState:UIControlStateNormal];
        
        geofenceMsg.text = @"长按地图，选择围栏中心点，并输入围栏半径";
        _btnStatus = 0;
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![geofenceRadius isExclusiveTouch]) {
        [geofenceRadius resignFirstResponder];
    }
}

/**
 *点中底图标注后会回调此接口
 *@param mapview 地图View
 *@param mapPoi 标注点信息
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    
    if (![geofenceRadius isExclusiveTouch]) {
        [geofenceRadius resignFirstResponder];
    }
}

/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    
    if (![geofenceRadius isExclusiveTouch]) {
        [geofenceRadius resignFirstResponder];
    }
}


/**
 * @brief 添加地理围栏完成后的回调，成功与失败都会调用
 * @param manager 地理围栏管理类
 * @param regions 成功添加的一个或多个地理围栏构成的数组
 * @param customID 用户执行添加围栏函数时传入的customID
 * @param error 添加失败的错误信息
 */
- (void)BMKGeoFenceManager:(BMKGeoFenceManager * _Nonnull)manager didAddRegionForMonitoringFinished:(NSArray <BMKGeoFenceRegion *> * _Nullable)regions customID:(NSString * _Nullable)customID error:(NSError * _Nullable)error
{
    
    if (error) {
        NSLog(@"add geofence error = %@", error);
        geofenceMsg.text = [NSString stringWithFormat:@"add error = %@", error];
    } else {
        
        NSLog(@"add circel geofence %@ success", regions.firstObject.customID);
    }
    
}


/**
 * @brief 地理围栏状态改变时回调，当围栏状态的值发生改变，定位失败都会调用
 * @param manager 地理围栏管理类
 * @param region 状态改变的地理围栏
 * @param customID 用户执行添加围栏函数时传入的customID
 * @param error 错误信息，如定位相关的错误
 */
- (void)BMKGeoFenceManager:(BMKGeoFenceManager * _Nonnull)manager didGeoFencesStatusChangedForRegion:(BMKGeoFenceRegion * _Nullable)region customID:(NSString * _Nullable)customID error:(NSError * _Nullable)error
{
    
    if (error) {
        NSLog(@"geofence error = %@", error);
        geofenceMsg.text = [NSString stringWithFormat:@"error = %@", error];
    } else {
        
        NSLog(@"geofence %@ status = %ld", region.customID, region.fenceStatus);
        switch(region.fenceStatus) {
            case BMKGeoFenceRegionStatusInside:
                geofenceMsg.text = @"地理围栏状态：进入地理围栏";
                break;
                
            case BMKGeoFenceRegionStatusStayed:
                
                geofenceMsg.text = @"地理围栏状态：停留在地理围栏";
                break;
                
                
            case BMKGeoFenceRegionStatusOutside:
                
                geofenceMsg.text = @"地理围栏状态：离开地理围栏";
                break;
                
                
            default:
                geofenceMsg.text = @"地理围栏状态：围栏状态未知";
                
                break;
        }
    }
    
}
@end
