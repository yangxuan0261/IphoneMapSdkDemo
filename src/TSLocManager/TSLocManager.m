//
//  TSLocManager.m
//  IphoneMapSdkDemo
//
//  Created by Bii on 2018/12/25.
//  Copyright © 2018 Baidu. All rights reserved.
//

#import "TSLocManager.h"
#import <BMKLocationkit/BMKLocationComponent.h>

static TSLocManager* g_sharedInstance = nil;

@interface TSLocManager ()<BMKLocationManagerDelegate>

@property (nonatomic,strong) BMKLocationManager* locationManager;
@property (nonatomic,strong) CLHeading* headingData;
@end

@implementation TSLocManager

+ (instancetype)initLocManagerWithJSONString:(NSString *)JSONString{
    static dispatch_once_t singleton;
    dispatch_once(&singleton, ^{
        g_sharedInstance = [[self alloc] init];
        [g_sharedInstance setupWithJSONString:JSONString];
    });
    return g_sharedInstance;
}

- (void)setupWithJSONString:(NSString*)JSONString{
    _locationManager = [[BMKLocationManager alloc] init];
    _locationManager.delegate = self;

    if(!JSONString.length)return;
    
    NSError *error = nil;
    NSDictionary* info = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[JSONString dataUsingEncoding:NSUTF8StringEncoding]
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if(error){
#ifdef DEBUG
        NSLog(@"JSON解析错误 = %@",error);
#endif
        return;
    }
    
    if(jsonObject && [jsonObject isKindOfClass:[NSDictionary class]]){
        info = (NSDictionary*)jsonObject;
    }else{
        return;
    }
    
    //**** 在下面进行获取配置的方法，对百度地图管理对象BMKLocationManager的实例进行配置
    /*
        info是一个字典。也就是键值对，是根据JSON字符串转化出来的，按需要去获取即可.
        比如JSON里有个字段叫loc，那么字典里也会有一个，key叫loc，那么可以使用info[@"loc"]获取
    */
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    _locationManager.distanceFilter = kCLLocationAccuracyBestForNavigation;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    _locationManager.allowsBackgroundLocationUpdates = NO;
    _locationManager.locationTimeout = 10;
    _locationManager.reGeocodeTimeout = 10;
}

+ (instancetype)shareInstance{
    return g_sharedInstance;
}

- (void)startLocService{
    [_locationManager startUpdatingLocation];
    [_locationManager startUpdatingHeading];
}

- (void)stopLocService{
    [_locationManager stopUpdatingLocation];
    [_locationManager stopUpdatingHeading];
}

#pragma mark - BMKDelegate
- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateHeading:(CLHeading *)heading{
    self.headingData = heading;
}

- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error{
    NSMutableDictionary* info = @{}.mutableCopy;
    info[TSLocManager_latitude] = @(location.location.coordinate.latitude);     // 经度
    info[TSLocManager_longitude] = @(location.location.coordinate.longitude);   // 纬度
    info[TSLocManager_magneticHeading] = @(_headingData.magneticHeading);       // 方向1
    info[TSLocManager_trueHeading] = @(_headingData.trueHeading);               // 方向2

    NSError *err = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:info
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if(err){
#ifdef DEBUG
        NSLog(@"JSON解析错误 = %@",error);
#endif
    }
    
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if(self.locCallBack){
        self.locCallBack(jsonString);
    }
}


@end
