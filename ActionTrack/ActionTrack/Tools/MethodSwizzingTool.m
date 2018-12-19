//
//  MethodSwizzingTool.m
//  demo
//
//  Created by Minsol on 2018/12/19.
//  Copyright © 2018 Minsol. All rights reserved.
//
/***
 *
 * SEL      :
 *          Defines an opaque type that represents a method selector.
 *
 * IMP      :
 *          A pointer to the start of a method implementation.
 *
 * Method   : typedef struct objc_method *Method;
 *          An opaque type that represents a method in a class definition.
 */
#import "MethodSwizzingTool.h"

@implementation MethodSwizzingTool


+(void)swizzingInstanceMethodForClass:(Class)cls originalSel:(SEL)originalSelector swizzingSel:(SEL)swizzingSelector{
    Class class = cls;
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method  swizzingMethod = class_getInstanceMethod(class, swizzingSelector);
    BOOL addMethod = class_addMethod(class,
                                     originalSelector,
                                     method_getImplementation(swizzingMethod),
                                     method_getTypeEncoding(swizzingMethod));
    if (addMethod) {
        class_replaceMethod(class,
                            swizzingSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzingMethod);
    }
}

+(void)swizzingClassMethodForClass:(Class)cls originalSel:(SEL)originalSelector swizzingSel:(SEL)swizzingSelector{
    Method method1 = class_getClassMethod(cls, originalSelector);
    Method method2 = class_getClassMethod(cls, swizzingSelector);
    method_exchangeImplementations(method1, method2);
}

//判断页面是否实现了某个sel
+ (BOOL)isContainSel:(SEL)sel inClass:(Class)class {
    unsigned int count;
    Method *methodList = class_copyMethodList(class,&count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *tempMethodString = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
        if ([tempMethodString isEqualToString:NSStringFromSelector(sel)]) {
            return YES;
        }
    }
    return NO;
}

//+(void)printMethodList:(Class)cls{
//    unsigned int count;
//    Method *methodList = class_copyMethodList(cls,&count);
//    for (int i = 0; i < count; i++) {
//        Method method = methodList[i];
//        IMP imp = method_getImplementation(method);
//
//        NSString *tempMethodString = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
//        if ([tempMethodString containsString:@"user"]) {
//            NSLog(@"imp===%p====%@",imp,tempMethodString);
//        }
//    }
//}

@end
