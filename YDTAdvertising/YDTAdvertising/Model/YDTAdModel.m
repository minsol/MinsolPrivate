//
//  YDTAdModel.m
//  A8TV_IPhone
//
//  Created byMinsol on 2017/9/6.
//  Copyright © 2017年 New Sense Networks Technology Co., Ltd.. All rights reserved.
//

#import "YDTAdModel.h"

@implementation YDTAdModel

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"sExtra"]) {
        NSString *sExtra = value ? value : @"";
        NSData *jsonData = [sExtra dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *sExtraDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        [super setValue:sExtraDic forKey:@"sExtraDic"];
    }
    [super setValue:value forKey:key];
}

-(CGFloat)adHeight{
    if (self.showType == A8AdvertisingViewTypeLargeImageWithTitle) {
        return (ScreenWidth - 24) * 0.5 + 73;
    }
    return 95.0f;
}
@end



