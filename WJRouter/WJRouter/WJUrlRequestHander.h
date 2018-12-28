//
//  WJUrlRequestHander.h
//  WJRouter
//
//  Created by Minsol on 2018/12/28.
//  Copyright © 2018 A8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJUrlRequest.h"

@interface WJUrlRequestHander : NSObject
- (instancetype)initWithUrlRequest:(WJUrlRequest*)urlRequest;
- (BOOL)handerUrlRequest;
- (BOOL)handerUrlRequestByRoute;
@end
