//
//  HotSpotDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by baidu on 2017/4/6.
//  Copyright © 2017年 Baidu. All rights reserved.
//

#ifndef HotSpotDemoViewController_h
#define HotSpotDemoViewController_h


#import <UIKit/UIKit.h>
#import <BMKLocationkit/BMKLocationComponent.h>

@interface HotSpotDemoViewController :  UIViewController <BMKLocationManagerDelegate>{
    
    
    IBOutlet UILabel *_resultMsg;
    IBOutlet UIButton *locbtn;
    
}

- (IBAction)btnTouchDown:(id)sender;

@end

#endif /* HotSpotDemoViewController_h */
