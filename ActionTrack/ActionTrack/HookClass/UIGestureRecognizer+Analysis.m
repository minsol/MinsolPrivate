//
//  UIGestureRecognizer+Analysis.m
//  demo
//
//  Created by Minsol on 2018/12/19.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "UIGestureRecognizer+Analysis.h"
#import "MethodSwizzingTool.h"
#import <objc/runtime.h>

@interface UIGestureRecognizer (gesture)
@property(nonatomic,copy)NSString * methodName;
@end

@implementation UIGestureRecognizer (gesture)
-(void)setMethodName:(NSString *)methodName{
    objc_setAssociatedObject(self, @"methodName", methodName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)methodName{
    return objc_getAssociatedObject(self, @"methodName");
}
@end

@implementation UIGestureRecognizer (Analysis)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [MethodSwizzingTool swizzingInstanceMethodForClass:[self class] originalSel:@selector(initWithTarget:action:) swizzingSel:@selector(user_initWithTarget:action:)];
    });
}

/**
 target : gesture2clicked: --->  target : ViewController/gesture2clicked: ---> UIGestureRecognizer : responseUser_gesture
 */
- (instancetype)user_initWithTarget:(nullable id)target action:(nullable SEL)action
{
    UIGestureRecognizer *selfGestureRecognizer = [self user_initWithTarget:target action:action];/// 实际上 -initWithTarget:action:
    
    if (!target && !action) {
        return selfGestureRecognizer;
    }
    
    if ([target isKindOfClass:[UIScrollView class]]) {
        return selfGestureRecognizer;
    }
    
    Class class = [target class];
    
    
    SEL sel = action;///target : gesture2clicked:
    
    NSString * sel_name = [NSString stringWithFormat:@"%s/%@", class_getName([target class]),NSStringFromSelector(action)];
    SEL sel_ =  NSSelectorFromString(sel_name);///target : ViewController/gesture2clicked:
    
    /// 将 target 的 ViewController/gesture2clicked: ---> 由 self 实现 responseUser_gesture:
    BOOL isAddMethod = class_addMethod(class,
                                       sel_,
                                       method_getImplementation(class_getInstanceMethod([self class], @selector(responseUser_gesture:))),
                                       nil);
    
    self.methodName = NSStringFromSelector(action);
    
    /// 将 target 原先的方法 gesture2clicked: 替换为 target : ViewController/gesture2clicked:
    if (isAddMethod) {
        Method selMethod = class_getInstanceMethod(class, sel);
        Method sel_Method = class_getInstanceMethod(class, sel_);
        method_exchangeImplementations(selMethod, sel_Method);
    }
    
    return selfGestureRecognizer;
}


/**
 UIGestureRecognizer : responseUser_gesture -> target : ViewController/gesture2clicked: ->  target : gesture2clicked:
 */
-(void)responseUser_gesture:(UIGestureRecognizer *)gesture
{
    
    NSString * identifier = [NSString stringWithFormat:@"%s/%@", class_getName([self class]),gesture.methodName];
    
    SEL sel = NSSelectorFromString(identifier);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL,id) = (void *)imp;
        func(self, sel,gesture);
    }
    [[DataContainer dataInstance] handWithTargetKey:self Key:@"GESTURE" Identifier:identifier];
}

@end
