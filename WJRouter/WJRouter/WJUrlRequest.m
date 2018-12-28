//
//  WJUrlRequest.m
//  WJRouter
//
//  Created by Minsol on 2018/12/28.
//  Copyright © 2018 A8. All rights reserved.
//

#import "WJUrlRequest.h"

@interface WJUrlRequest()

@end

@implementation WJUrlRequest
+ (instancetype)requestWithUrlString:(NSString *)URLString withParameters:(NSDictionary *)parameters{
    ///汉字编码
    NSString *encodedUrl = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [[self alloc] initWithUrl:[NSURL URLWithString:encodedUrl] withParameters:parameters];
}

+ (instancetype)requestWithUrl:(NSURL *)URL withParameters:(NSDictionary *)parameters{
    return [[self alloc] initWithUrl:URL withParameters:parameters];
}

- (instancetype)initWithUrl:(NSURL *)URL withParameters:(NSDictionary *)parameters{
    if (self = [super init]){
        self.requestUrl = URL;
        NSLog(@"%@",URL.scheme);
        NSString *host = URL.host;
        NSString *path = URL.path;
        if ([path characterAtIndex:0] == '/') {
            path = [path substringFromIndex:1];
        }
        NSMutableDictionary *parametDictionary = [NSMutableDictionary dictionaryWithDictionary:parameters];
        [parametDictionary setObject:path forKey:@"ViewController"];
        [parametDictionary setObject:host forKey:@"RouterVCStatus"];
        self.parameters = parametDictionary;
    }
    return self;
}

-(NSString *)requestIndentify{
    return self.requestUrl.description;
}

@end
