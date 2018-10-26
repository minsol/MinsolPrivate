//
//  YDTNetworkTool.h
//  A8TV_IPhone
//
//  Created by 白云 on 2018/8/22.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDTNetworkResponseObject.h"
#import <UIKit/UIKit.h>

#define YDTNETWORKTOOL [YDTNetworkTool share]

typedef NS_ENUM(NSUInteger, YDTNetworkEnvironment) {
    YDTNetworkEnvironmentDefault = 0,   /**< 默认(根据项目环境选择网络环境 Debug or Release) */
    YDTNetworkEnvironmentDevelopment,   /**< 开发环境 */
    YDTNetworkEnvironmentRelease,       /**< 正式环境 */
};

typedef NS_ENUM(NSUInteger, YDTNetworkMethod) {
    YDTNetworkMethodGET,    /**< GET请求 */
    YDTNetworkMethodPOST,   /**< POST请求 */
};

typedef NS_ENUM(NSInteger, YDTNetworkReachabilityStatus) {
    YDTNetworkReachabilityStatusUnknown          = -1,  /**< 未知 */
    YDTNetworkReachabilityStatusNotReachable     = 0,   /**< 无连接 */
    YDTNetworkReachabilityStatusReachableViaWWAN = 1,   /**< WWAN */
    YDTNetworkReachabilityStatusReachableViaWiFi = 2,   /**< WiFi */
};

typedef void(^YDTRequestBlock)(YDTNetworkResponseObject *responseObject, NSError *error);

/** 网络变化通知key */
UIKIT_EXTERN NSString * const YDTNetworkStatusChangeNotification;

@interface YDTNetworkTool : NSObject

#pragma mark - Property
/// 网络环境
@property (nonatomic, assign) YDTNetworkEnvironment environment;
/// 网络状态
@property (nonatomic, assign) YDTNetworkReachabilityStatus networkStatus;
/// 请求地址配置
@property (nonatomic, strong, readonly) NSDictionary *apiHosts;

#pragma mark - Method

/// 获取单例
+ (instancetype)share;

#pragma mark 请求
/**
 发起网络请求

 @param URLString 请求地址
 @param method 请求类型
 @param param 请求参数
 @param completed 完成回调
 */
- (void)requestWithURL:(NSString *)URLString method:(YDTNetworkMethod)method param:(id)param completed:(YDTRequestBlock)completed;

/**
 发起网络请求(JSON方式)
 
 @param URLString 请求地址
 @param method 请求类型
 @param param 请求参数
 @param completed 完成回调
 */
- (void)JSONRequestWithURL:(NSString *)URLString method:(YDTNetworkMethod)method param:(id)param completed:(YDTRequestBlock)completed;

#pragma mark - GCD
#define dispatch_async_global_queue(block)\
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);\

#define dispatch_async_main_queue(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
@end

