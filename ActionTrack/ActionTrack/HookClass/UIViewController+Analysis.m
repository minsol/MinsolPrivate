//
//  UIViewController+Analysis.m
//  demo
//
//  Created by Minsol on 2018/12/19.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "UIViewController+Analysis.h"
#import "MethodSwizzingTool.h"


@implementation UIViewController (Analysis)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalAppearSelector = @selector(viewWillAppear:);
        SEL swizzingAppearSelector = @selector(user_viewWillAppear:);
        [MethodSwizzingTool swizzingInstanceMethodForClass:[self class] originalSel:originalAppearSelector swizzingSel:swizzingAppearSelector];
        
        SEL originalDisappearSelector = @selector(viewWillDisappear:);
        SEL swizzingDisappearSelector = @selector(user_viewWillDisappear:);
        [MethodSwizzingTool swizzingInstanceMethodForClass:[self class] originalSel:originalDisappearSelector swizzingSel:swizzingDisappearSelector];
        
        SEL originalDidLoadSelector = @selector(viewDidLoad);
        SEL swizzingDidLoadSelector = @selector(user_viewDidLoad);
        [MethodSwizzingTool swizzingInstanceMethodForClass:[self class] originalSel:originalDidLoadSelector swizzingSel:swizzingDidLoadSelector];
        
    });
}


-(void)user_viewWillAppear:(BOOL)animated{
    [self user_viewWillAppear:animated];
}


-(void)user_viewWillDisappear:(BOOL)animated{
    [self user_viewWillDisappear:animated];
    
}

-(void)user_viewDidLoad{
    
    [self user_viewDidLoad];
    NSString * identifier = [NSString stringWithFormat:@"%@", [self class]];
    [[DataContainer dataInstance] handWithTargetKey:self Key:@"PAGEPV" Identifier:identifier];
}


@end
