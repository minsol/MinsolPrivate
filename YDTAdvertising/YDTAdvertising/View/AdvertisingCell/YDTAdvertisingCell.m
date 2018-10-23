//
// YDTAdvertisingCell.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/8/3.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTAdvertisingCell.h"
#import "YDTAdvertisingCellLargeImage.h"
#import "YDTAdvertisingCellLargeImageTitle.h"
#import "YDTAdvertisingCellLeftImage.h"
@implementation YDTAdvertisingCell

#pragma mark - Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self configSubviews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configSubviews];
}

#pragma mark - Config views
- (void)configSubviews {
    [self loadSubviews];
    [self loadSubviewsLayout];
}

- (void)loadSubviews {
    
}

- (void)loadSubviewsLayout {
    [self.advertisingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
}

#pragma mark - Actions

#pragma mark - Public methods
+(id)initWithType:(A8AdvertisingViewType)advertisingType{
    switch (advertisingType) {
        case A8AdvertisingViewTypeLeftImage:{
            return [[YDTAdvertisingCellLeftImage alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDTAdvertisingCellLeftImage.defaultIdentify];
        }
            break;
        case A8AdvertisingViewTypeLargeImageWithTitle:{
            return [[YDTAdvertisingCellLargeImageTitle alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDTAdvertisingCellLargeImageTitle.defaultIdentify];
        }
            break;
        case A8AdvertisingViewTypeLeftImageRightButton:{
            return [[YDTAdvertisingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDTAdvertisingCell.defaultIdentify];
        }
            break;
        case A8AdvertisingViewTypeLargeImage:{
            return [[YDTAdvertisingCellLargeImage alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDTAdvertisingCellLargeImage.defaultIdentify];
        }
            break;
        default:{
            return [[YDTAdvertisingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YDTAdvertisingCell.defaultIdentify];
        }
            break;
    }
}
-(void)updateSubViewsConstraintsIfNeeded{
    
}
-(void)setAdvertisingModel:(YDTAdModel *)advertisingModel{
    [self.advertisingView setAdvertisingModel:advertisingModel];
}
#pragma mark - Private methods

#pragma mark - Protocol conformance

#pragma mark - Setter & Getter
+ (NSString *)defaultIdentify {
    return NSStringFromClass(self);
}
+(void)setDefaultIdentify:(NSString *)defaultIdentify{
    
}
@end
