//
//  YDTAdNetWorkManager.h
//  A8TV_IPhone
//
//  Created by Xunqf on 16/4/19.
//  Copyright © 2016年 New Sense Networks Technology Co., Ltd.. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface YDTAdNetWorkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;
- (void)addCookie;
- (void)addUserAgent;
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
