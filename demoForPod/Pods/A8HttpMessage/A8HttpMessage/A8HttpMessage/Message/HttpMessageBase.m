//
//  HttpMessageBase.m
//  A8HttpMessage
//
//  Created by minsol on 2018/4/13.
//  Copyright © 2018年 Minsol. All rights reserved.
//

#import "HttpMessageBase.h"

@interface HttpMessageBase()
@property (nonatomic, strong) YDTNetworkTool  *manger;
@property (nonatomic, assign) NSInteger code;

@end

@implementation HttpMessageBase
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manger = [YDTNetworkTool share];
        self.method = YDTNetworkMethodGET;//默认get
        self.urlHost = @"";
        self.path = @"";
    }
    return self;
}

-(NSInteger)code{
    if (self.responseObject) {
        return 1;
    }
    return -1;
}

-(void)sendCallBack:(void(^)(NSInteger code))callBack{
    [self buildRequest];
    NSLog(@"%@",self.urlHost);
    NSLog(@"%@",self.path);
    NSLog(@"%@",self.param);
    [self.manger requestWithURL:[NSString stringWithFormat:@"%@%@",self.urlHost,self.path] method:self.method param:self.param completed:^(YDTNetworkResponseObject *responseObject, NSError *error) {
        [self parseResponse:responseObject];
        callBack(self.code);
    }];
}


-(void)buildRequest{
    
}

-(void)parseResponse:(YDTNetworkResponseObject *)responseObject{
    if (!responseObject) {return;}
    self.responseObject = responseObject;
}
@end
