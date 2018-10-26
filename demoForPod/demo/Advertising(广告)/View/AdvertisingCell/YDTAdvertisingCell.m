//
//  YDTAdvertisingCell.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/8/3.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTAdvertisingCell.h"

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
-(void)setAdvertisingModel:(XQFAdModel *)advertisingModel{
    [self.advertisingView setAdvertisingModel:advertisingModel];
}
-(void)updateSubViewsConstraintsIfNeeded{
    
}
#pragma mark - Private methods

#pragma mark - Protocol conformance

#pragma mark - Setter & Getter

@end
