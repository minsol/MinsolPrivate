//
// YDTAdvertisingCell.h
//  A8TV_IPhone
//
//  Created by Minsol on 2018/8/3.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDTAdvertisingView.h"

@interface YDTAdvertisingCell : UITableViewCell
/// 默认注册id
@property (nonatomic, copy, class) NSString *defaultIdentify;

#pragma mark - Property
@property (nonatomic, strong)YDTAdvertisingView *advertisingView;

#pragma mark - Method
+(id)initWithType:(A8AdvertisingViewType)advertisingType;
-(void)setAdvertisingModel:(YDTAdModel *)advertisingModel;
-(void)updateSubViewsConstraintsIfNeeded;
@end
