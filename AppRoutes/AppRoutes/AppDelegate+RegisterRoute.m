//
//  AppDelegate+RegisterRoute.m
//  JLRouteScheme
//
//  Created by Minsol on 2018/12/21.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "AppDelegate+RegisterRoute.h"
#import <JLRoutes.h>
#import <objc/runtime.h>

@implementation AppDelegate (RegisterRoute)

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    if ([[url.scheme lowercaseString] isEqualToString:[RouteDemo lowercaseString]]) {
        return [[JLRoutes routesForScheme:RouteDemo] routeURL:url];
    }
    return true;
}


- (BOOL)openURLString:(NSString*)urlString{
    ///汉字编码
    NSString *encodedUrl = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:encodedUrl]];
    if (canOpen) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:encodedUrl] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:encodedUrl]];
        }
    }
    return canOpen;
}



//Scheme://style/controller----> RouteOne://push/FirstNextViewController?key1=value1&key2=value2
- (void)registerRouteWithScheme:(NSString *)scheme{
    [[JLRoutes routesForScheme:scheme] addRoute:@"/:style/:controller"handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        Class class = NSClassFromString(parameters[@"controller"]);
        UIViewController *nextVC = [[class alloc] init];
        [self paramToVc:nextVC param:parameters];
        UIViewController *currentVc = [self currentViewController];
        if ([parameters[@"style"] isEqualToString:@"push"]) {
            [currentVc.navigationController pushViewController:nextVC animated:true];
        }else{
            [currentVc.navigationController presentViewController:nextVC animated:true completion:nil];
        }
        return YES;
    }];
}





//确定是哪个viewcontroller
-(UIViewController *)currentViewController{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = self.window.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}
//传参数
-(void)paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters{
    //        runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}
@end
