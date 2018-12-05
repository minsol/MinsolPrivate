//
//  UIView+CornerRadius.m
//  demo
//
//  Created by Minsol on 2018/12/5.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "UIView+CornerRadius.h"
#import <objc/runtime.h>

@interface UIView ()
@property (assign, nonatomic) CGFloat wjRadius;
@property (assign, nonatomic) UIRectCorner wjRoundingCorners;
@property (assign, nonatomic) CGFloat wjBorderWidth;
@property (strong, nonatomic) UIColor *wjBorderColor;
@end

@implementation UIView (CornerRadius)

//- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor rectCornerType:(UIRectCorner)rectCornerType{
//    if (self = [super init]) {
//        [self wj_cornerRadius:cornerRadius borderWidth:borderWidth borderColor:borderColor rectCornerType:rectCornerType];
//    }
//    return self;
//}

/**
 crop corner radius & draw Border
 
 @param cornerRadius cornerRadius
 @param borderWidth borderWidth
 @param borderColor borderColor
 @param rectCornerType rectCornerType
 */
- (void)wj_cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor rectCornerType:(UIRectCorner)rectCornerType{
    self.wjRadius = cornerRadius;
    self.wjRoundingCorners = rectCornerType;
    [self wj_cornerRadius:cornerRadius rectCornerType:rectCornerType];
    [self wj_attachBorderWidth:borderWidth borderColor:borderColor];
}

/**
 crop round
 */
- (void)wj_cornerRadiusRoundingRect{
    [self wj_cornerRadius:self.frame.size.width/2.0 rectCornerType:UIRectCornerAllCorners];
}

/**
 crop corner radius
 
 @param cornerRadius cornerRadius
 @param rectCornerType rectCornerType
 */
- (void)wj_cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType{
    self.wjRadius = cornerRadius;
    self.wjRoundingCorners = rectCornerType;
    CGRect rect = self.bounds;
    // Create the path
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:rectCornerType
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    // Set the newly created shape layer as the mask for the view's layer
    self.layer.mask = maskLayer;
}

/**
 draw Border 绘制边框
 
 @param borderWidth borderWidth
 @param borderColor borderColor
 */
- (void)wj_attachBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    CGRect rect = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:rect];
    if ( self.wjRadius || self.wjRoundingCorners ) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                         byRoundingCorners:self.wjRoundingCorners
                                               cornerRadii:CGSizeMake(self.wjRadius, self.wjRadius)];
    }

    CAShapeLayer *borderLayer=[CAShapeLayer layer];
    borderLayer.path    =   maskPath.CGPath;
    borderLayer.fillColor  = [UIColor clearColor].CGColor;
    borderLayer.strokeColor    = borderColor.CGColor;
    borderLayer.lineWidth      = borderWidth;
    borderLayer.frame = rect;
    [self.layer addSublayer:borderLayer];
}

#pragma mark property
- (UIRectCorner)wjRoundingCorners {
    return [objc_getAssociatedObject(self, _cmd) unsignedLongValue];
}

- (void)setWjRoundingCorners:(UIRectCorner)roundingCorners {
    objc_setAssociatedObject(self, @selector(wjRoundingCorners), @(roundingCorners), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wjRadius {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
-(void)setWjRadius:(CGFloat)wjRadius{
    objc_setAssociatedObject(self, @selector(wjRadius), @(wjRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wjBorderWidth {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
-(void)setWjBorderWidth:(CGFloat)wjBorderWidth{
    objc_setAssociatedObject(self, @selector(wjBorderWidth), @(wjBorderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)wjBorderColor {
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setWjBorderColor:(UIColor *)wjBorderColor{
    objc_setAssociatedObject(self, @selector(wjBorderColor), wjBorderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
