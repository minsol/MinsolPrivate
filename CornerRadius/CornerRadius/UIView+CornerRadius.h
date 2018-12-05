//
//  UIView+CornerRadius.h
//  demo
//
//  Created by Minsol on 2018/12/5.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)

//- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor rectCornerType:(UIRectCorner)rectCornerType;


/**
 crop corner radius && draw Border

 @param cornerRadius cornerRadius
 @param borderWidth borderWidth
 @param borderColor borderColor
 @param rectCornerType rectCornerType
 */
- (void)wj_cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor rectCornerType:(UIRectCorner)rectCornerType;

/**
 crop round
 */
- (void)wj_cornerRadiusRoundingRect;

/**
 crop corner radius
 
 @param cornerRadius cornerRadius
 @param rectCornerType rectCornerType
 */
- (void)wj_cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

/**
 draw Border 绘制边框
 
 @param borderWidth borderWidth
 @param borderColor borderColor
 */
- (void)wj_attachBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;



@end
