//
//  HttpMessageCenter.m
//  A8HttpMessage
//
//  Created by minsol on 2018/4/13.
//  Copyright © 2018年 Minsol. All rights reserved.
//

#import "HttpMessageCenter.h"
#import "HttpMessageBase.h"

@implementation HttpMessageCenter
+ (instancetype)sharedManager {
    static HttpMessageCenter *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[HttpMessageCenter alloc]init];
    });
    return _manager;
}

-(void)sendMessage:(HttpMessageBase*)message callBack:(void(^)(NSInteger code))callBack{
    [message sendCallBack:callBack];
}

@end
