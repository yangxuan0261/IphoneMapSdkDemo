//
//  CircleGeofenceDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/4/7.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#ifndef CircleGeofenceDemoViewController_h
#define CircleGeofenceDemoViewController_h

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>

@interface CircleGeofenceDemoViewController :  UIViewController <BMKMapViewDelegate, BMKGeoFenceManagerDelegate>{
    
    IBOutlet BMKMapView *_mapView;
    IBOutlet UITextField *geofenceRadius;
    
    IBOutlet UILabel *geofenceMsg;
    IBOutlet UIButton *geofenceBtn;
}
- (IBAction)geofenceBtntrigger:(id)sender;


@end

#endif /* CircleGeofenceDemoViewController_h */
