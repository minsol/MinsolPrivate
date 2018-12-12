//
//  NSDictionary+AddParams.m
//  demo
//
//  Created by Minsol on 2018/12/12.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "NSDictionary+AddParams.h"

@implementation NSDictionary (AddParams)

- (NSDictionary *)addParam:(void (^)(DictionaryParamMaker *make))block{
    DictionaryParamMaker *make = [[DictionaryParamMaker alloc] initDictionary:self];
    block(make);
    return make.paramDictionary;
}

@end


@implementation NSMutableDictionary (AddParams)

#pragma mark - Chaining
- (NSMutableDictionary *(^)(NSString *key, id object))addParam{
    return ^NSMutableDictionary *(NSString *key, id object) {
        [self addParam:object forKey:key];
        return self;
    };
}


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

@end
