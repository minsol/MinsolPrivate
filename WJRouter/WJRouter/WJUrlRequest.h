//
//  WJUrlRequest.h
//  WJRouter
//
//  Created by Minsol on 2018/12/28.
//  Copyright © 2018 A8. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface WJUrlRequest : NSObject

@property (nonatomic, strong) NSURL *requestUrl;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, strong) NSString *requestIndentify;

+ (instancetype)requestWithUrlString:(NSString *)URLString withParameters:(NSDictionary *)parameters;
+ (instancetype)requestWithUrl:(NSURL *)URL withParameters:(NSDictionary *)parameters;
@end
