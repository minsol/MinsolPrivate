//
//  NSDictionary+AddParams.h
//  demo
//
//  Created by Minsol on 2018/12/12.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DictionaryParamMaker.h"

@interface NSDictionary (AddParams)

- (NSDictionary *)addParam:(void (^)(DictionaryParamMaker *make))block;

@end

@interface NSMutableDictionary (AddParams)

/**
 增加键值对
 
 @param object 值
 @param key 值对应的key
 */
- (void)addParam:(id)object forKey:(NSString *)key;

#pragma mark - Chaining
/**
 这个分类方法可以用于直接添加参数
 添加参数(key, value)
 
 @return Param
 */
- (NSMutableDictionary *(^)(NSString *key, id object))addParam;

@end
