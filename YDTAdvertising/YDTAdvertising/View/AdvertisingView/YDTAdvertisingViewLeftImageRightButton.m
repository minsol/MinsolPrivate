//
// YDTAdvertisingViewLeftImageRightButton.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/7/10.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTAdvertisingViewLeftImageRightButton.h"

@interface YDTAdvertisingViewLeftImageRightButton()
@property (nonatomic, strong) UIImageView *enterImageView; /**< 进入 */
@property (nonatomic, strong) UILabel *enterLabel; /**< 进入 */
@end

@implementation YDTAdvertisingViewLeftImageRightButton

- (instancetype)initWithType:(A8AdvertisingViewType)advertisingType{
    self = [super initWithType:advertisingType];
    if (self) {
        self.advertisingTagView.hidden = true;
        [self.contentView addSubview:self.enterImageView];
        [self.contentView addSubview:self.enterLabel];
        self.advertisingImage.layer.cornerRadius = 22;
        self.advertisingImage.clipsToBounds = true;
        self.advertisingSubTitel.font = [UIFont systemFontOfSize:14];
        [self setUpConstraints];
    }
    return self;
}

-(void)setAdvertisingModel:(YDTAdModel *)advertisingModel{
    self.advertisingSubTitel.text = advertisingModel.sDesc;
    self.advertisingTitle.text = advertisingModel.sTitle;
    [super setAdvertisingModel:advertisingModel];
}

-(void)setUpConstraints{
    [super setUpConstraints];
    [self.advertisingImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.height.width.equalTo(@44);
    }];
    
    // 名称
    [self.advertisingTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.advertisingImage.mas_right);
        make.top.equalTo(self.advertisingImage.mas_top);
        make.right.equalTo(self.enterImageView.mas_left);
    }];
    
    // 描述
    [self.advertisingSubTitel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.advertisingTitle);
        make.bottom.equalTo(self.advertisingImage);
    }];
    
    // 进入按钮
    [self.enterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@24);
    }];
    
    [self.enterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.enterImageView);
    }];
}


-(UIImageView *)enterImageView{
    if (!_enterImageView) {
        _enterImageView = [[UIImageView alloc]init];
        _enterImageView.image = [UIImage imageNamed:@"community_Follow"];
    }
    return _enterImageView;
}
-(UILabel *)enterLabel{
    if (!_enterLabel) {
        _enterLabel = [[UILabel alloc] init];
        _enterLabel.font =  [UIFont systemFontOfSize:12.0];
//        _enterLabel.textColor = [UIColor a8_textBlackColor];
        _enterLabel.text = @"购彩";
    }
    return _enterLabel;
}
@end
