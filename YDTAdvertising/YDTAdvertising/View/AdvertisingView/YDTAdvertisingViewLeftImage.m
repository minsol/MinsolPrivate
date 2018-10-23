//
// YDTAdvertisingViewLeftImage.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/7/10.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTAdvertisingViewLeftImage.h"

@implementation YDTAdvertisingViewLeftImage
- (instancetype)initWithType:(A8AdvertisingViewType)advertisingType{
    self = [super initWithType:advertisingType];
    if (self) {
        [self setUpConstraints];
    }
    return self;
}

-(void)setAdvertisingModel:(YDTAdModel *)advertisingModel{
    [super setAdvertisingModel:advertisingModel];
    self.advertisingImage.contentMode = UIViewContentModeScaleAspectFill;
    if (advertisingModel.nAdType.integerValue == 6) {
        self.advertisingImage.contentMode = UIViewContentModeScaleToFill;
    }
    // 广告标题
    self.advertisingTitle.text = advertisingModel.sTitle;
    // 广告描述
    self.advertisingSubTitel.text = advertisingModel.sDesc;
    
    [self.advertisingTagView setTagType:YDTNewsTagTypeAdvertising];
    if (advertisingModel.sExtraDic && advertisingModel.sExtraDic[@"extLabel"]) {
        [self.advertisingTagView setTagType:YDTNewsTagTypeCustom title:[NSString stringWithFormat:@"%@",advertisingModel.sExtraDic[@"extLabel"]]];
    }
}

-(void)setUpConstraints{
    [super setUpConstraints];
    // 广告图片
    [self.advertisingImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(12);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(110.0f);
        make.height.mas_equalTo(66.0f);
    }];
    
    // 广告标题
    [self.advertisingTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.advertisingImage);
        make.left.equalTo(self.advertisingImage.mas_right).mas_offset(8);
        make.right.equalTo(self.contentView).mas_offset(-12);
    }];
    
    // 广告描述
    [self.advertisingSubTitel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.advertisingTitle);
        make.right.equalTo(self.advertisingTagView.mas_left).mas_offset(-12);
        make.bottom.equalTo(self.advertisingTagView);
    }];
    
    // 广告标签
    [self.advertisingTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).mas_offset(-12);
        make.bottom.equalTo(self.contentView).mas_offset(-11);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(16);
    }];
}

@end
