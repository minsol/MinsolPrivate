//
//  YDTAdNetWorkManager.m
//  A8TV_IPhone
//
//  Created by Xunqf on 16/4/19.
//  Copyright © 2016年 New Sense Networks Technology Co., Ltd.. All rights reserved.
//

#import "YDTAdNetWorkManager.h"

@implementation YDTAdNetWorkManager

+ (instancetype)sharedManager {
    static YDTAdNetWorkManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [self manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];//  AFHTTPRequestSerializer AFJSONRequestSerializer
//        _manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        _manager.requestSerializer.timeoutInterval = 30;
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];//  AFHTTPResponseSerializer AFJSONResponseSerializer
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                  @"text/html",
                                                                                  @"text/json",
                                                                                  @"text/plain",
                                                                                  @"text/javascript",
                                                                                  @"text/xml",
                                                                                  @"image/*"]];
    });
    
    return _manager;
}

- (void)addCookie{
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"newCookie"];
    if (cookie) {
        [self.requestSerializer setValue:cookie forHTTPHeaderField:@"ck"];
    }
}
- (void)addUserAgent{
    NSMutableString *userAgent = [NSMutableString stringWithString:[[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]];
    [self.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
}
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"GET"
                                                        URLString:URLString
                                                       parameters:parameters
                                                          success:success
                                                          failure:failure];
    
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"POST"
                                                        URLString:URLString
                                                       parameters:parameters
                                                          success:success
                                                          failure:failure];
    
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method
                                                                   URLString:URLString
                                                                  parameters:parameters
                                                                       error:&serializationError];
    if (serializationError) {
        if (failure) {
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
        }
        
        return nil;
    }    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
        } else {
            if (success) {
                success(dataTask, responseObject);
            }
        }
    }];
    
    return dataTask;
}


@end
