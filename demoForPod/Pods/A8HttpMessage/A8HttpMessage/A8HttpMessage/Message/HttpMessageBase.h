//
//  HttpMessageBase.h
//  A8HttpMessage
//
//  Created by minsol on 2018/4/13.
//  Copyright © 2018年 Minsol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDTNetworkTool.h"

@interface HttpMessageBase : NSObject
@property (nonatomic, strong) NSString  *urlHost;
@property (nonatomic, strong) NSString  *path;
@property (nonatomic, assign) YDTNetworkMethod  method;
@property (nonatomic, strong) NSDictionary *param;

@property (nonatomic, strong) YDTNetworkResponseObject  *responseObject;

-(void)buildRequest;
-(void)parseResponse:(YDTNetworkResponseObject *)responseObject;
-(void)sendCallBack:(void(^)(NSInteger code))callBack;
@end
