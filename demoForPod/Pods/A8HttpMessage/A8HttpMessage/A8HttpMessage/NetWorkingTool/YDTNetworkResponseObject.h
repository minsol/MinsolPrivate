//
//  YDTNetworkResponseObject.h
//  A8TV_IPhone
//
//  Created by 白云 on 2018/8/23.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YDTNetworkResponseType) {
    YDTNetworkResponseTypeUnknown = 0,              /**< 未知类型(无法解析) */
    YDTNetworkResponseTypeDictionary = 1,           /**< 字典类型 */
    YDTNetworkResponseTypeArray,                    /**< 数组类型 */
    YDTNetworkResponseTypeLiveSourceDictionary = 1, /**< 线路加密字典类型 */
    YDTNetworkResponseTypeLiveSourceArray,          /**< 线路加密数组类型 */
    YDTNetworkResponseTypeUTF8String,               /**< 字符串类型 */
};

@interface YDTNetworkResponseObject : NSObject

#pragma mark - Property
/// 数据类型
@property (nonatomic, assign) YDTNetworkResponseType type;
/// 原数据
@property (nonatomic, strong) NSData *originalData;

#pragma mark - Method
/**
 将NSData对象解析为Response对象

 @param data data
 @return Response
 */
+ (instancetype)responseWithData:(NSData *)data;

// TODO:type 为 Dictionary 类型

/**
 取Response中的Dictionary类型数据

 @param key 数据对应的key
 @return NSDictionary(无值或者值类型不为Dictionary时nil)
 */
- (NSDictionary *)dictionaryDataWithKey:(NSString *)key;

/**
 取Response中的Array类型数据

 @param key 数据对应的key
 @return NSArray(无值或者值类型不为Array时为nil)
 */
- (NSArray *)arrayDataWithKey:(NSString *)key;

/**
 取Response中的String类型的数据，如果数据类型为number会自动转换为String

 @param key 数据对应的key
 @return NSString(无值或值类型不为String和Number时为nil)
 */
- (NSString *)stringTypeDataWithKey:(NSString *)key;

/**
 取Response中的String类型数据

 @param key 数据对应的key
 @return NSString(无值或者值类型不为String时为nil)
 */
- (NSString *)stringDataWithKey:(NSString *)key;

/**
 取Response中的number类型数据

 @param key 数据对应的key
 @return NSNumber(无值或者值类型不为number时为nil)
 */
- (NSNumber *)numberDataWithKey:(NSString *)key;

/**
 将Response转换为Dictionary类型数据

 @return NSDictionary
 */
- (NSDictionary *)dictionaryData;

// TODO:type 为 Array 类型

/**
 将Response转换为Array类型数据

 @return NSArray
 */
- (NSArray *)arrayData;

// TODO:type 为 String 类型

/**
 将Response转换为字符串数据(UTF8)

 @return NSString
 */
- (NSString *)utf8StringData;

@end
