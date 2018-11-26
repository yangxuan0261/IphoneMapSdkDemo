//
//  SerialLocDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/4/7.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#ifndef SerialLocDemoViewController_h
#define SerialLocDemoViewController_h

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>

@interface SerialLocDemoViewController : UIViewController <BMKMapViewDelegate, BMKLocationManagerDelegate>{
    
    IBOutlet BMKMapView *_mapView;
    IBOutlet UITextView *locMessage;
    
    IBOutlet UIButton *locBtn;
    
    IBOutlet UITextField *distance;
    
}
- (IBAction)locBtnDown:(id)sender;
- (IBAction)switchValueChanged:(id)sender;

@end
#endif /* SerialLocDemoViewController_h */
