//
//  MethodSwizzingTool.h
//  demo
//
//  Created by Minsol on 2018/12/19.
//  Copyright © 2018 Minsol. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataContainer.h"

@interface MethodSwizzingTool : NSObject
/**
 *  对象方法的交换
 *
 *  @param cls    哪个类
 *  @param originalSelector 方法1(原本的方法)
 *  @param swizzingSelector 方法2(要替换成的方法)
 */
+(void)swizzingInstanceMethodForClass:(Class)cls originalSel:(SEL)originalSelector swizzingSel:(SEL)swizzingSelector;
/**
 *  类方法的交换
 *
 *  @param cls    哪个类
 *  @param originalSelector 方法1
 *  @param swizzingSelector 方法2
 */
+(void)swizzingClassMethodForClass:(Class)cls originalSel:(SEL)originalSelector swizzingSel:(SEL)swizzingSelector;

+ (BOOL)isContainSel:(SEL)sel inClass:(Class)class;
@end
