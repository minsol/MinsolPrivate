//
//  AppDelegate+RegisterRoute.h
//  JLRouteScheme
//
//  Created by Minsol on 2018/12/21.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "AppDelegate.h"

#define RouteDemo @"RouteDemo"

@interface AppDelegate (RegisterRoute)


/**
 注册路由 scheme

 @param scheme scheme
 */
- (void)registerRouteWithScheme:(NSString *)scheme;


/**
 界面路由
 
 @param urlString 匹配scheme规则
 @return true or false
 */
- (BOOL)openURLString:(NSString*)urlString;

@end
