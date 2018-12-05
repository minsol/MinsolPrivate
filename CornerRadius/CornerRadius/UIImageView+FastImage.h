//
//  UIImageView+FastImage.h
//  demo
//
//  Created by Minsol on 2018/12/5.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FastImage)

/**
 通过 SDWedImage 快速加载图片

 @param imagePath 图片路径、名称、url、UIImage
 @param placeholder 占位图
 */
- (void)wj_setFastImageWithImagePath:(nullable id)imagePath placeholderImage:(nullable UIImage *)placeholder;

@end
