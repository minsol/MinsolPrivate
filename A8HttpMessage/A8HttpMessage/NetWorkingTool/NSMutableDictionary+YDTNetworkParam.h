//
//  NSMutableDictionary+YDTNetworkParam.h
//  demo
//
//  Created by Minsol on 2018/12/12.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSMutableDictionary *(^YDTNetworkParamSetBlock)(NSString *key, id object);
typedef NSMutableDictionary *(^YDTNetworkParamBlock)(void);

@interface NSMutableDictionary (YDTNetworkParam)

/**
 增加键值对
 
 @param object 值
 @param key 值对应的key
 */
- (void)addParam:(id)object forKey:(NSString *)key;

#pragma mark - Chaining
/**
 添加参数(key, value)
 
 @return Param
 */
- (YDTNetworkParamSetBlock)addParam;

///**
// 添加直播Id
// 
// @return Param
// */
//- (YDTNetworkParamBlock)addLiveId;
//
///**
// 添加用户手机号
// 
// @return Param
// */
//- (YDTNetworkParamBlock)addUserPhone;
@end
