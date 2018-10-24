//
//  YDTNetworkTool.m
//  A8TV_IPhone
//
//  Created by 白云 on 2018/8/22.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTNetworkTool.h"
#import <AFNetworking.h>



/** 网络变化通知key */
NSString * const YDTNetworkStatusChangeNotification = @"YDTNetworkStatusChangeNotification";

typedef NS_ENUM(NSUInteger, YDTNetworkToolRequestType) {
    YDTNetworkToolRequestTypeDefault = 0,   /**< 默认请求方式 */
    YDTNetworkToolRequestTypeJSON,          /**< json格式进行请求 */
};

@interface YDTNetworkTool ()

@property (nonatomic, strong) AFHTTPSessionManager *requestManager;
@property (nonatomic, strong) AFHTTPRequestSerializer *defaultRequestSerializer;
@property (nonatomic, strong) AFJSONRequestSerializer *jsonRequestSerializer;

@end

@implementation YDTNetworkTool

#pragma mark - Life cycle
+ (instancetype)share {
    static YDTNetworkTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
        instance.requestManager = [AFHTTPSessionManager manager];
        instance.requestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        instance.requestManager.requestSerializer.timeoutInterval = 30.0;
        instance.requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSSet *acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                              @"text/html",
                                                              @"text/json",
                                                              @"text/plain",
                                                              @"text/javascript",
                                                              @"text/xml",
                                                              @"image/*"]];
        instance.requestManager.responseSerializer.acceptableContentTypes = acceptableContentTypes;
        
        instance.defaultRequestSerializer = instance.requestManager.requestSerializer;
        instance.jsonRequestSerializer = [AFJSONRequestSerializer serializer];
        
        // 初始化环境配置
        instance.environment = YDTNetworkEnvironmentDefault;
        // 启动网络状态监听
        [instance listenNetworkStatus];
        
    });
    return instance;
}

#pragma mark - Public methods

#pragma mark 请求
/// 发起请求
- (void)requestWithURL:(NSString *)URLString method:(YDTNetworkMethod)method param:(id)param completed:(YDTRequestBlock)completed {
    [self requestWithType:YDTNetworkToolRequestTypeDefault URL:URLString method:method param:param completed:completed];
}

/// 发起请求(JSON方式)
- (void)JSONRequestWithURL:(NSString *)URLString method:(YDTNetworkMethod)method param:(id)param completed:(YDTRequestBlock)completed {
    [self requestWithType:YDTNetworkToolRequestTypeJSON URL:URLString method:method param:param completed:completed];
}

- (void)requestWithType:(YDTNetworkToolRequestType)type URL:(NSString *)URLString method:(YDTNetworkMethod)method param:(id)param completed:(YDTRequestBlock)completed {
    // 无回调不进行操作
    if (nil == completed) {
        return;
    }
    // 开启网络指示器
    dispatch_async_main_queue(^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
    YDTRequestBlock block = ^(id responseObject, NSError *error){
        // 关闭网络指示器
        dispatch_async_main_queue(^{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        });
        dispatch_async_global_queue(^{
            YDTNetworkResponseObject *object = [YDTNetworkResponseObject responseWithData:responseObject];
            dispatch_async_main_queue(^{
                completed(object,error);
            });
        });
    };
    
    if (YDTNetworkToolRequestTypeJSON == type) {
        self.requestManager.requestSerializer = self.jsonRequestSerializer;
    }
    else {
        self.requestManager.requestSerializer = self.defaultRequestSerializer;
    }
    
    switch (method) {
        case YDTNetworkMethodPOST: {
            [self.requestManager POST:URLString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
            }];
        }
            break;
        case YDTNetworkMethodGET:
        default: {
            [self.requestManager GET:URLString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
            }];
        }
            break;
    }
}

#pragma mark - Private methods
/// 监听网络状态
- (void)listenNetworkStatus {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.networkStatus = (NSInteger)status;
        // 发送网络变化通知
        [[NSNotificationCenter defaultCenter] postNotificationName:YDTNetworkStatusChangeNotification object:[NSNumber numberWithInteger:status]];
    }];
}

#pragma mark - Protocol conformance

#pragma mark - Setter & Getter

@end

