//
//  NSMutableDictionary+YDTNetworkParam.m
//  demo
//
//  Created by Minsol on 2018/12/12.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "NSMutableDictionary+YDTNetworkParam.h"

@implementation NSMutableDictionary (YDTNetworkParam)
/**
 增加键值对
 
 @param object 值
 @param key 值对应的key
 */
- (void)addParam:(id)object forKey:(NSString *)key {
    if (nil != object) {
        [self setObject:object forKey:key];
    }
    else {
        [self setObject:[NSNull null] forKey:key];
    }
}

#pragma mark - Chaining
- (YDTNetworkParamSetBlock)addParam {
    return ^NSMutableDictionary *(NSString *key, id object) {
        [self addParam:object forKey:key];
        return self;
    };
}

//- (YDTNetworkParamBlock)addLiveId {
//    return ^NSMutableDictionary *(void) {
//        NSString *uid = @"";
//        if (APP_SHARED_CONFIGURE.userEntity) {
//            uid = APP_SHARED_CONFIGURE.userEntity.zhiboId;
//        }else {
//            uid = APP_SHARED_CONFIGURE.guestEntity.zhiboId;
//        }
//        [self addParam:uid forKey:@"uid"];
//        return self;
//    };
//}
//
//- (YDTNetworkParamBlock)addUserPhone {
//    return ^NSMutableDictionary *(void) {
//        NSString *phoneNumStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserPhoneNumber"];
//        [self addParam:phoneNumStr forKey:@"phone"];
//        return self;
//    };
//}
@end
