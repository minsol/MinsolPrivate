//
//  WJUrlRouterManager.m
//  WJRouter
//
//  Created by Minsol on 2018/12/28.
//  Copyright © 2018 A8. All rights reserved.
//

#import "WJUrlRouterManager.h"

@interface WJUrlRouterManager()

@property (nonatomic, strong) NSMutableDictionary *requestDic;

@end

@implementation WJUrlRouterManager

+ (instancetype)sharedManager{
    static WJUrlRouterManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
        _sharedManager.requestDic = [NSMutableDictionary dictionary];
    });
    
    return _sharedManager;
}

- (void)openURLWithRequest:(WJUrlRequest *)urlRequest completionHandler:(void (^ __nullable)(BOOL success))completion{
    WJUrlRequestHander *hander = [[WJUrlRequestHander alloc] initWithUrlRequest:urlRequest];
    if ([urlRequest.requestUrl.host containsString:@"root"]) {
        [hander handerUrlRequest];
    }else{
        [hander handerUrlRequestByRoute];
    }
    [self.requestDic setObject:hander forKey:urlRequest.requestIndentify];
}

- (BOOL)openURL:(NSURL *)url{
    NSLog(@"%@",url.description);
    if (!url) {return false;}
    WJUrlRequestHander *hander = [self.requestDic objectForKey:url.description];
    if (hander) {
        return [hander handerUrlRequest];
    }
    return true;
}


@end
