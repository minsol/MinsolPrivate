//
//  HttpMessageCenter.h
//  A8HttpMessage
//
//  Created by minsol on 2018/4/13.
//  Copyright © 2018年 Minsol. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HttpMessageBase;

@interface HttpMessageCenter : NSObject
+ (instancetype)sharedManager;

-(void)sendMessage:(HttpMessageBase*)message callBack:(void(^)(NSInteger code))callBack;

@end
