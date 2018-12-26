//
//  TSLocManager.h
//  IphoneMapSdkDemo
//
//  Created by Bii on 2018/12/25.
//  Copyright © 2018 Baidu. All rights reserved.
//

/*
 调用顺序：
 1.[TSLocManager initLocManagerWithJSONString:xxx]的方式初始化，只调用一次。这里可以获取单例保存起来，也可以不保存，随意。
 2.[TSLocManager shareInstance]获取位置管理者的单例对象
 3.开启定位，使用startLocService
 4.使用TSLocManager的实例对象去的locCallBack属性去实时获取位置信息。
    比如
    [TSLocManager shareInstance].locCallBack = ^(NSString *JSONString) {
        // 每次定位更新都会执行这里
    };
 5.根据情况关闭定位，使用stopLocService
 */

#import <Foundation/Foundation.h>

#define TSLocManager_latitude @"TSLocManager_latitude"                  // 经度
#define TSLocManager_longitude @"TSLocManager_longitude"                // 维度
#define TSLocManager_magneticHeading @"TSLocManager_magneticHeading"    // 方向
#define TSLocManager_trueHeading @"TSLocManager_trueHeading"            // 方向2


typedef void(^locCallBack)(NSString* JSONString);

@interface TSLocManager : NSObject

/**
 功能：定位开启时，实时更新位置的方法
 @param CallBack 当定位更新的时候回调，内容以JSON的形式返回，返回的json字符串可能会使空吧，需要注意。
 */
@property (nonatomic,copy) locCallBack locCallBack;

/**
 静态方法
 功能：初始化TSLocManager并返回单例对象，应只调用一次，多次调用没有别的效果。
 @param JSONString 自定义配置的JSON字符串,
 @return 返回TSLocManager单例对象
 */
+ (instancetype)initLocManagerWithJSONString:(NSString*)JSONString;

/**
 静态方法
 功能：获取TSLocManager单例对象，可调用多次
 @return TSLocManager单例对象
 */
+ (instancetype)shareInstance;


/**
 实例方法
 功能：开启定位
 */
- (void)startLocService;


/**
 实例方法
 功能：关闭定位
 */
- (void)stopLocService;

@end

