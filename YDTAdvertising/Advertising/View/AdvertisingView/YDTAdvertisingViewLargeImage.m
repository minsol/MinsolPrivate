//
// YDTAdvertisingViewLargeImage.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/7/10.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTAdvertisingViewLargeImage.h"

@implementation YDTAdvertisingViewLargeImage

- (instancetype)initWithType:(A8AdvertisingViewType)advertisingType{
    self = [super initWithType:advertisingType];
    if (self) {
        self.advertisingTitle.hidden = true;
        self.advertisingSubTitel.hidden = true;
        [self setUpConstraints];
    }
    return self;
}

-(void)setAdvertisingModel:(YDTAdModel *)advertisingModel{
    [super setAdvertisingModel:advertisingModel];
}

-(void)setUpConstraints{
    [super setUpConstraints];
    [self.advertisingImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(12, 12, 16,12));
    }];
    [self.advertisingTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.advertisingImage.mas_right).offset(-8);
        make.top.equalTo(self.advertisingImage.mas_top).offset(8);
        make.width.equalTo(@32);
        make.height.equalTo(@16);
    }];
}

-(void)updateSubViewsConstraintsIfNeeded{
    [self.advertisingImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(8,60,8,12));
    }];
}

@end
