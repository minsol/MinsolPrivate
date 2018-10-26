//
//  YDTNetworkResponseObject.m
//  A8TV_IPhone
//
//  Created by 白云 on 2018/8/23.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTNetworkResponseObject.h"

@interface YDTNetworkResponseObject ()

@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *utf8String;

@end

@implementation YDTNetworkResponseObject

#pragma mark - Life cycle
+ (instancetype)responseWithData:(NSData *)data {
    YDTNetworkResponseObject *object = [self new];
    object.originalData = data;
    // 不是Data类型，解析失败
    if (![data isKindOfClass:[NSData class]]) {
        object.type = YDTNetworkResponseTypeUnknown;
    }
    // 进行解析
    else {
        NSError *error = nil;
        id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            object.dictionary = responseObject;
            object.type = YDTNetworkResponseTypeDictionary;
        }
        else if ([responseObject isKindOfClass:[NSArray class]]) {
            object.array = responseObject;
            object.type = YDTNetworkResponseTypeArray;
        }else {
            object.type = YDTNetworkResponseTypeUnknown;
        }
    }
    return object;
}

#pragma mark - Public methods
// TODO:type 为 Dictionary 类型
/// 取Response中的Dictionary类型数据
- (NSDictionary *)dictionaryDataWithKey:(NSString *)key {
    NSDictionary *dict = nil;
    if (nil != _dictionary && [_dictionary.allKeys containsObject:key] && [_dictionary[key] isKindOfClass:[NSDictionary class]]) {
        dict = _dictionary[key];
    }
    return dict;
}

/// 取Response中的Array类型数据
- (NSArray *)arrayDataWithKey:(NSString *)key {
    NSArray *array = nil;
    if (nil != _dictionary && [_dictionary.allKeys containsObject:key] && [_dictionary[key] isKindOfClass:[NSArray class]]) {
        array = _dictionary[key];
    }
    return array;
}

/// 取Response中的String类型的数据，如果数据类型为number会自动转换为String
- (NSString *)stringTypeDataWithKey:(NSString *)key {
    NSString *string = [self stringDataWithKey:key];
    if (!string) {
        string = [self numberDataWithKey:key].stringValue;
    }
    return string;
}

/// 取Response中的String类型数据
- (NSString *)stringDataWithKey:(NSString *)key {
    NSString *string = nil;
    if (nil != _dictionary && [_dictionary.allKeys containsObject:key] && [_dictionary[key] isKindOfClass:[NSString class]]) {
        string = _dictionary[key];
    }
    return string;
}

/// 取Response中的number类型数据
- (NSNumber *)numberDataWithKey:(NSString *)key {
    NSNumber *number = nil;
    if (nil != _dictionary && [_dictionary.allKeys containsObject:key] && [_dictionary[key] isKindOfClass:[NSNumber class]]) {
        number = _dictionary[key];
    }
    return number;
}

/// 将Response转换为Dictionary类型数据
- (NSDictionary *)dictionaryData {
    return _dictionary;
}

// TODO:type 为 Array 类型
/// 将Response转换为Array类型数据
- (NSArray *)arrayData {
    return _array;
}

// TODO:type 为 String 类型
/// 将Response转换为字符串数据(UTF8)
- (NSString *)utf8StringData {
    return _utf8String;
}

#pragma mark - Private methods

#pragma mark - Protocol conformance

#pragma mark - Setter & Getter

@end
