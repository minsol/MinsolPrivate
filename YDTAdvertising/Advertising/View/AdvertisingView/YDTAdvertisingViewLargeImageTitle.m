//
// YDTAdvertisingViewLargeImageTitle.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/8/3.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTAdvertisingViewLargeImageTitle.h"

@implementation YDTAdvertisingViewLargeImageTitle

#pragma mark - Life cycle
- (instancetype)initWithType:(A8AdvertisingViewType)advertisingType{
    self = [super initWithType:advertisingType];
    if (self) {
        [self setUpConstraints];
    }
    return self;
}

#pragma mark - Config views

#pragma mark - Actions

#pragma mark - Public methods
-(void)setAdvertisingModel:(YDTAdModel *)advertisingModel{
    [super setAdvertisingModel:advertisingModel];
    self.advertisingImage.contentMode = UIViewContentModeScaleAspectFill;
    if (advertisingModel.nAdType.integerValue == 3 || advertisingModel.nAdType.integerValue == 6) {
        self.advertisingImage.contentMode = UIViewContentModeScaleToFill;
    }
    // 广告标题
    self.advertisingTitle.text = advertisingModel.sTitle;
    // 广告描述
    self.advertisingSubTitel.text = advertisingModel.sDesc;
}

#pragma mark - Private methods
-(void)setUpConstraints{
    [super setUpConstraints];
    // 广告标题
    [self.advertisingTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
    }];
    
    // 广告图片
    [self.advertisingImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.advertisingTitle.mas_bottom);
        make.left.right.equalTo(self.advertisingTitle);
        make.bottom.equalTo(self.advertisingSubTitel.mas_top);
    }];
    
    // 广告描述
    [self.advertisingSubTitel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.advertisingTagView);
        make.left.equalTo(self.advertisingTitle);
        make.right.equalTo(self.advertisingTagView.mas_left);
    }];
    
    // 广告标签
    [self.advertisingTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.width.equalTo(@32);
        make.height.equalTo(@16);
    }];

}


#pragma mark - Protocol conformance

#pragma mark - Setter & Getter

@end
