//
//  BackgroundLocDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/8/24.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#ifndef BackgroundLocDemoViewController_h
#define BackgroundLocDemoViewController_h
#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>

@interface BackgroundLocDemoViewController : UIViewController <BMKMapViewDelegate, BMKLocationManagerDelegate>{
    
    IBOutlet BMKMapView *_mapView;
    IBOutlet UITextView *locMessage;
    
    IBOutlet UIButton *locbtn;
    
    
}
- (IBAction)locBtnDown:(id)sender;

@end

#endif /* BackgroundLocDemoViewController_h */
