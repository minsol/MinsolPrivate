//
//  YDTAdBaseModel.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/4/13.
//Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTAdBaseModel.h"
#import <objc/runtime.h>
@interface YDTAdBaseModel ()



@end

@implementation YDTAdBaseModel

#pragma mark - Lifecycle

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        if (dict && ![dict isKindOfClass:[NSNull class]]) {
            [self setValuesForKeysWithDictionary:dict];
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@缺少字段:%@", self, key);
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if([value isKindOfClass:[NSNull class]]) {
        value = @"";
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        value = [NSString stringWithFormat:@"%@", value];
    }
    [super setValue:value forKey:key];
}

/**
 *  归档
 *
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    //  利用runtime获取实例变量的列表
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        //  取出i位置对应的实例变量
        Ivar ivar = ivars[i];
        //  查看实例变量的名字
        const char *name = ivar_getName(ivar);
        //  C语言字符串转化为NSString
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        //  利用KVC取出属性对应的值
        id value = [self valueForKey:nameStr];
        //  归档
        [aCoder encodeObject:value forKey:nameStr];
    }
    //  记住C语言中copy出来的要进行释放
    free(ivars);
}

/**
 *  解档
 *
 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i ++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:key];
            
            //  设置到成员变量身上
            [self setValue:value forKey:key];
        }
        
        free(ivars);
    }
    
    return self;
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - 懒加载



@end
