//
//  YDTAdBaseModel.h
//  A8TV_IPhone
//
//  Created by Minsol on 2018/4/13.
//Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDTAdBaseModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
