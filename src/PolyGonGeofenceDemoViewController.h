//
//  PolyGonGeofenceDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/4/8.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#ifndef PolyGonGeofenceDemoViewController_h
#define PolyGonGeofenceDemoViewController_h
#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>

@interface PolyGonGeofenceDemoViewController :  UIViewController <BMKMapViewDelegate, BMKGeoFenceManagerDelegate>{
    
    IBOutlet BMKMapView *_mapView;

    
    IBOutlet UILabel *geofenceMsg;
    IBOutlet UIButton *geofenceBtn;
}
- (IBAction)geofenceBtntrigger:(id)sender;


@end

#endif /* PolyGonGeofenceDemoViewController_h */
