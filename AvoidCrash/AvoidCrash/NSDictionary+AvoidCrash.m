//
//  NSDictionary+AvoidCrash.m
//  demo
//
//  Created by Minsol on 2018/12/19.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "NSDictionary+AvoidCrash.h"
#import "CrashAvoidConst.h"

@implementation NSDictionary (AvoidCrash)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [CrashAvoidManager exchangeClassMethod:self method1Sel:@selector(dictionaryWithObjects:forKeys:count:) method2Sel:@selector(avoidCrashDictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)avoidCrashDictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self avoidCrashDictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"AvoidCrash default is to remove nil key-values and instance a dictionary.";
        [CrashAvoidManager noteErrorWithException:exception defaultToDo:defaultToDo];
        
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self avoidCrashDictionaryWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}
@end
