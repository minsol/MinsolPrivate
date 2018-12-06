//
//  UIImageView+FastImage.m
//  demo
//
//  Created by Minsol on 2018/12/5.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "UIImageView+FastImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
/**
 * imageNamed:
 * 用imageNamed的方式加载时，系统会把图像Cache到内存。
 * 如果图像比较大，或者图像比较多，用这种方式会消耗很大的内存，而且释放图像的 内存是一件相对来说比较麻烦的事情。在APP被干掉之后才释放。
 * 所以在YYImage里面找了个重写的方法
 *
 * 像 placeholder 这样的图片就可以用 imageNamed
 */

@implementation UIImageView (FastImage)

- (void)wj_setFastImageWithImagePath:(nullable id)imagePath placeholderImage:(nullable UIImage *)placeholder{
    if ([imagePath isKindOfClass:[NSString class]]) {
        if ([imagePath hasPrefix:@"http"]) {
            [self sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:placeholder];
        } else {
            UIImage *image = [self YYImageImageNamed:imagePath];
            if (!image) {
                image = [UIImage imageWithContentsOfFile:imagePath];
            }
            self.image = image;
        }
    } else if ([imagePath isKindOfClass:[NSURL class]]) {
        [self sd_setImageWithURL:imagePath placeholderImage:placeholder];
    }else if ([imagePath isKindOfClass:[UIImage class]]) {
        self.image = (UIImage *)imagePath;
    }
}


/**
 由于 imageNamed 加载会有缓存的问题，所以使用 YYImage 里面使用的方法加载。
 https://github.com/ibireme/YYImage
 
 @param name name
 @return UIImage
 */
-(UIImage *)YYImageImageNamed:(NSString*)name{
    if (name.length == 0) return nil;
    if ([name hasSuffix:@"/"]) return nil;
    
    NSString *res = name.stringByDeletingPathExtension;
    NSString *ext = name.pathExtension;
    NSString *path = nil;
    CGFloat scale = 1;
    
    // If no extension, guess by system supported (same as UIImage).
    NSArray *exts = ext.length > 0 ? @[ext] : @[@"", @"png", @"jpeg", @"jpg", @"gif", @"webp", @"apng"];
    NSArray *scales = _NSBundlePreferredScales();
    for (int s = 0; s < scales.count; s++) {
        scale = ((NSNumber *)scales[s]).floatValue;
        NSString *scaledName = _NSStringByAppendingNameScale(res, scale);
        for (NSString *e in exts) {
            path = [[NSBundle mainBundle] pathForResource:scaledName ofType:e];
            if (path) break;
        }
        if (path) break;
    }
    if (path.length == 0) return nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data.length == 0) return nil;
    return [[UIImage alloc] initWithData:data scale:scale];
}

/**
 An array of NSNumber objects, shows the best order for path scale search.
 e.g. iPhone3GS:@[@1,@2,@3] iPhone5:@[@2,@3,@1]  iPhone6 Plus:@[@3,@2,@1]
 */
static NSArray *_NSBundlePreferredScales() {
    static NSArray *scales;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenScale = [UIScreen mainScreen].scale;
        if (screenScale <= 1) {
            scales = @[@1,@2,@3];
        } else if (screenScale <= 2) {
            scales = @[@2,@3,@1];
        } else {
            scales = @[@3,@2,@1];
        }
    });
    return scales;
}

/**
 Add scale modifier to the file name (without path extension),
 From @"name" to @"name@2x".
 
 e.g.
 <table>
 <tr><th>Before     </th><th>After(scale:2)</th></tr>
 <tr><td>"icon"     </td><td>"icon@2x"     </td></tr>
 <tr><td>"icon "    </td><td>"icon @2x"    </td></tr>
 <tr><td>"icon.top" </td><td>"icon.top@2x" </td></tr>
 <tr><td>"/p/name"  </td><td>"/p/name@2x"  </td></tr>
 <tr><td>"/path/"   </td><td>"/path/"      </td></tr>
 </table>
 
 @param scale Resource scale.
 @return String by add scale modifier, or just return if it's not end with file name.
 */
static NSString *_NSStringByAppendingNameScale(NSString *string, CGFloat scale) {
    if (!string) return nil;
    if (fabs(scale - 1) <= __FLT_EPSILON__ || string.length == 0 || [string hasSuffix:@"/"]) return string.copy;
    return [string stringByAppendingFormat:@"@%@x", @(scale)];
}

@end
