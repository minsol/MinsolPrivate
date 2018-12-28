//
//  WJUrlRequestHander.m
//  WJRouter
//
//  Created by Minsol on 2018/12/28.
//  Copyright © 2018 A8. All rights reserved.
//

#import "WJUrlRequestHander.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

typedef enum : NSInteger{
    RouterPush,                      //push
    RouterPresent,                   //模态跳转
    RouterRoot,                      //设为当前window的根控制器
    RouterNone,
}RouterVCStatus;

RouterVCStatus NSStringToRouterVCStatus(NSString *string){
    if ([string  isEqualToString:@"root"]) {
        return RouterRoot;
    }else if ([string  isEqualToString:@"push"]) {
        return RouterPush;
    }else if ([string  isEqualToString:@"present"]) {
        return RouterPresent;
    }
    return RouterNone;
}

@interface WJUrlRequestHander()
@property (nonatomic, strong) WJUrlRequest *urlRequest;
@end

@implementation WJUrlRequestHander

- (instancetype)initWithUrlRequest:(WJUrlRequest*)urlRequest{
    self = [super init];
    if (self) {
        self.urlRequest = urlRequest;
    }
    return self;
}

- (BOOL)handerUrlRequestByRoute{
    return [[UIApplication sharedApplication] openURL:self.urlRequest.requestUrl];
}

- (BOOL)handerUrlRequest{
    Class class = NSClassFromString(self.urlRequest.parameters[@"ViewController"]);
    UIViewController *viewController = [[class alloc] init];
    NSString *routerVCStatus = [NSString stringWithFormat:@"%@",self.urlRequest.parameters[@"RouterVCStatus"]];
    
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    switch (NSStringToRouterVCStatus(routerVCStatus)) {
        case RouterRoot:{
            NSString *navigation = [NSString stringWithFormat:@"%@",self.urlRequest.parameters[@"navigation"]];
            if (navigation) {
                Class class = NSClassFromString(navigation);
                delegate.window.rootViewController = [[class alloc]initWithRootViewController:viewController];
            }else{
                delegate.window.rootViewController =  viewController;
            }
            [delegate.window makeKeyAndVisible];
        }
            break;
        case RouterPush:{
            UIViewController *rootViewController = delegate.window.rootViewController;
            UIViewController *currentViewController = [self getCurrentVCFrom:delegate.window.rootViewController];
            UINavigationController *navi = nil;
            if ([rootViewController isKindOfClass:[UINavigationController class]]) {
                navi = (UINavigationController*)rootViewController;
            }else{
                navi = currentViewController.navigationController ?: rootViewController.navigationController;
            }
            [navi pushViewController:viewController animated:true];
        }
            break;
        case RouterPresent:{
            UIViewController *currentViewController = [self getCurrentVCFrom:delegate.window.rootViewController];
            [currentViewController presentViewController:viewController animated:YES completion:nil];
        }
            break;
        default:
            return false;
            break;
    }
    return true;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}

@end
