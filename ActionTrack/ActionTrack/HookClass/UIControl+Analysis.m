//
//  UIControl+Analysis.m
//  demo
//
//  Created by Minsol on 2018/12/19.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "UIControl+Analysis.h"
#import "MethodSwizzingTool.h"

@implementation UIControl (Analysis)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzingSelector = @selector(user_sendAction:to:forEvent:);
        [MethodSwizzingTool swizzingInstanceMethodForClass:[self class] originalSel:originalSelector swizzingSel:swizzingSelector];
    });
}


-(void)user_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [self user_sendAction:action to:target forEvent:event];
    NSString * identifier = [NSString stringWithFormat:@"%@/%@", [target class], NSStringFromSelector(action)];
    [[DataContainer dataInstance] handWithTargetKey:target Key:@"ACTION" Identifier:identifier];
}

@end
