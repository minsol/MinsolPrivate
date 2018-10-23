//
// YDTVoiceAdModel.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/6/21.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTVoiceAdModel.h"



@implementation YDTVoiceAdModel
- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"batch_ma"] && [value isKindOfClass:[NSArray class]]) {
        NSMutableArray *batch_maArray = [NSMutableArray array];
        for (NSDictionary *dic  in value) {
            YDTVoiceModel *voice = [[YDTVoiceModel alloc]initWithDictionary:dic];
            [batch_maArray addObject:voice];
        }
        value = batch_maArray;
    }
    [super setValue:value forKey:key];
}
@end


@implementation YDTVoiceModel

@end
