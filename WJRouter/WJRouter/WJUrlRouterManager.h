//
//  WJUrlRouterManager.h
//  WJRouter
//
//  Created by Minsol on 2018/12/28.
//  Copyright © 2018 A8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJUrlRequestHander.h"

@interface WJUrlRouterManager : NSObject

+ (instancetype)sharedManager;

- (void)openURLWithRequest:(WJUrlRequest *)urlRequest completionHandler:(void (^ __nullable)(BOOL success))completion;
- (BOOL)openURL:(NSURL *)url;

@end
