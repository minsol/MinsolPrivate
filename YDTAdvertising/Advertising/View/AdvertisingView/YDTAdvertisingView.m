//
//  A8AdvertisingView.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/7/10.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTAdvertisingView.h"
#import "YDTAdvertisingViewLeftImage.h"
#import "YDTAdvertisingViewLargeImageTitle.h"
#import "YDTAdvertisingViewLargeImage.h"
#import "YDTAdvertisingViewLeftImageRightButton.h"

@interface YDTAdvertisingView ()

@property (nonatomic,assign) A8AdvertisingViewType advertisingType;/**< 广告类型  */

@end

@implementation YDTAdvertisingView

+(id)initWithType:(A8AdvertisingViewType)advertisingType{
    switch (advertisingType) {
        case A8AdvertisingViewTypeLeftImage:{
            return [[YDTAdvertisingViewLeftImage alloc]initWithType:advertisingType];
        }
            break;
        case A8AdvertisingViewTypeLargeImageWithTitle:{
            return [[YDTAdvertisingViewLargeImageTitle alloc]initWithType:advertisingType];
        }
            break;
        case A8AdvertisingViewTypeLeftImageRightButton:{
            return [[YDTAdvertisingViewLeftImageRightButton alloc]initWithType:advertisingType];
        }
            break;
        case A8AdvertisingViewTypeLargeImage:{
            return [[YDTAdvertisingViewLargeImage alloc]initWithType:advertisingType];
        }
            break;
        default:{
            return [[YDTAdvertisingView alloc]initWithType:advertisingType];
        }
            break;
    }
}

- (instancetype)initWithType:(A8AdvertisingViewType)advertisingType{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.advertisingType = advertisingType;
        [self addSubview:self.contentView];
        [self addSubview:self.bottomLineView];
        [self.contentView addSubview:self.advertisingImage];
        [self.contentView addSubview:self.advertisingTitle];
        [self.contentView addSubview:self.advertisingSubTitel];
        [self.contentView addSubview:self.advertisingTagView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(advertisingtapGesture)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

///广告点击事件
-(void)advertisingtapGesture{
    if (self.advertisingClicked) {self.advertisingClicked();}
}

-(void)setAdvertisingModel:(YDTAdModel *)advertisingModel{
    _advertisingModel = advertisingModel;
    NSURL *imageUrl = [NSURL URLWithString:advertisingModel.sImgUrl];
    self.advertisingImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
}

-(void)setUpConstraints{
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@0.5);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.bottomLineView.mas_top);
    }];
}
-(void)updateSubViewsConstraintsIfNeeded{
    
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIImageView *)advertisingImage{
    if (!_advertisingImage) {
        _advertisingImage = [[UIImageView alloc]init];
        _advertisingImage.contentMode = UIViewContentModeScaleAspectFill;
        _advertisingImage.userInteractionEnabled = true;
        _advertisingImage.clipsToBounds = true;
    }
    return _advertisingImage;
}

-(UILabel *)advertisingTitle{
    if (!_advertisingTitle) {
        _advertisingTitle = [[UILabel alloc] init];
        _advertisingTitle.font = [UIFont systemFontOfSize:16];
//        _advertisingTitle.textColor = [UIColor a8_textBlackColor];
        _advertisingTitle.numberOfLines = 2;
    }
    return _advertisingTitle;
}

-(UILabel *)advertisingSubTitel{
    if (!_advertisingSubTitel) {
        _advertisingSubTitel = [[UILabel alloc] init];
        _advertisingSubTitel.font = [UIFont systemFontOfSize:12.0f];
//        _advertisingSubTitel.textColor = [UIColor a8_textGreyColor];
    }
    return _advertisingSubTitel;
}

-(YDTNewsTagView *)advertisingTagView{
    if (!_advertisingTagView) {
        _advertisingTagView = [[YDTNewsTagView alloc] init];
        [_advertisingTagView setTagType:YDTNewsTagTypeAdvertising];
    }
    return _advertisingTagView;
}

-(UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
//        _bottomLineView.backgroundColor = [UIColor a8_backgroundGreyColor];
    }
    return _bottomLineView;
}

@end
