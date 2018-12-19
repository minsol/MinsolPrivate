//
//  UITableView+Analysis.m
//  demo
//
//  Created by Minsol on 2018/12/19.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "UITableView+Analysis.h"
#import "MethodSwizzingTool.h"
#import <objc/runtime.h>

@implementation UITableView (Analysis)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalAppearSelector = @selector(setDelegate:);
        SEL swizzingAppearSelector = @selector(user_setDelegate:);
        [MethodSwizzingTool swizzingInstanceMethodForClass:[self class] originalSel:originalAppearSelector swizzingSel:swizzingAppearSelector];
    });
}



-(void)user_setDelegate:(id<UITableViewDelegate>)delegate
{
    [self user_setDelegate:delegate];
    
    SEL sel = @selector(tableView:didSelectRowAtIndexPath:);
    
    SEL sel_ =  NSSelectorFromString([NSString stringWithFormat:@"%@/%@/%ld", NSStringFromClass([delegate class]), NSStringFromClass([self class]),self.tag]);
    
    
    //因为 tableView:didSelectRowAtIndexPath:方法是optional的，所以没有实现的时候直接return
    if (![MethodSwizzingTool isContainSel:sel inClass:[delegate class]]) {
        
        return;
    }
    
    IMP imp = method_getImplementation(class_getInstanceMethod([self class], @selector(user_tableView:didSelectRowAtIndexPath:)));
    BOOL addsuccess = class_addMethod([delegate class],
                                      sel_,
                                      imp,
                                      nil);
    //如果添加成功了就直接交换实现， 如果没有添加成功，说明之前已经添加过并交换过实现了
    if (addsuccess) {
        Method selMethod1 = class_getInstanceMethod([delegate class], sel);
        Method sel_Method1 = class_getInstanceMethod([delegate class], sel_);
        method_exchangeImplementations(selMethod1, sel_Method1);
    }
}

// 由于我们交换了方法， 所以在tableview的 didselected 被调用的时候， 实质调用的是以下方法：
-(void)user_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@/%@/%ld", NSStringFromClass([self class]),  NSStringFromClass([tableView class]), tableView.tag]);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL,id,id) = (void *)imp;
        func(self, sel,tableView,indexPath);
    }
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString * identifier = [NSString stringWithFormat:@"%@/%@/%ld", [self class],[tableView class], tableView.tag];
    [[DataContainer dataInstance] handWithTargetKey:cell Key:@"TABLEVIEW" Identifier:identifier];
}

@end
