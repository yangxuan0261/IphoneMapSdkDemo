//
//  IsInChinaDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/8/24.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#ifndef IsInChinaDemoViewController_h
#define IsInChinaDemoViewController_h
#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>

@interface IsInChinaDemoViewController : UIViewController <BMKMapViewDelegate, BMKLocationManagerDelegate>{
    
    IBOutlet BMKMapView *_mapView;
    IBOutlet UITextView *locMessage;
    
    IBOutlet UIButton *locBtn;

    
}
- (IBAction)locBtnDown:(id)sender;


@end

#endif /* IsInChinaDemoViewController_h */
