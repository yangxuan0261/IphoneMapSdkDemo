//
//  SingleLocDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/4/5.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#ifndef SingleLocDemoViewController_h
#define SingleLocDemoViewController_h
#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>

@interface SingleLocDemoViewController :  UIViewController <BMKMapViewDelegate, BMKLocationManagerDelegate>{
    
    IBOutlet BMKMapView *_mapView;

    IBOutlet UISwitch *_addrSwitch;

    IBOutlet UITextView *locMessage;

    IBOutlet UIButton *locbtn;
}

- (IBAction)addrSwitchValueChange:(id)sender;
- (IBAction)locBtnTouch:(id)sender;

- (IBAction)hotspotValueChanged:(id)sender;

@end
#endif /* SingleLocDemoViewController_h */
