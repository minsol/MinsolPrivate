//
// YDTNewsTagView.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/8/2.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTNewsTagView.h"
#define HEX_COLOR(hex) [UIColor colorWithRed:((hex&0xff0000)>>16)/255.0 green:((hex&0x00ff00)>>8)/255.0 blue:((hex&0xff)>>0)/255.0 alpha:1]
#define HEX_COLOR_ALPHA(hex,a) [UIColor colorWithRed:((hex&0xff0000)>>16)/255.0 green:((hex&0x00ff00)>>8)/255.0 blue:((hex&0xff)>>0)/255.0 alpha:a]   //十六进制颜色宏，带透明度

@interface YDTNewsTagView()
#pragma mark - Property
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UILabel *tagTitleLabel;
@end

@implementation YDTNewsTagView

#pragma mark - Life cycle


#pragma mark - Config views
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    [self loadSubviews];
    [self loadSubviewsLayout];
}
/**
 加载子视图
 */
- (void)loadSubviews{
    self.clipsToBounds = true;
    self.layer.cornerRadius = 2.0;
    self.contentView = [[UIView alloc]init];
    [self addSubview:self.contentView];
    self.leftView = [[UIView alloc]init];
    [self addSubview:self.leftView];
    self.tagTitleLabel = [[UILabel alloc]init];
    self.tagTitleLabel.font = [UIFont systemFontOfSize:10];
    self.tagTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.tagTitleLabel];
}

/**
 设置子视图布局
 */
- (void)loadSubviewsLayout{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(@3);
    }];
    [self.tagTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.left.equalTo(self.leftView.mas_left);
    }];
}
#pragma mark - Actions

#pragma mark - Public methods
-(void)setTagType:(YDTNewsTagType)tagType title:(NSString *)title{
    [self setTagType:tagType];
    self.tagTitleLabel.text = title;
}

-(void)setTagType:(YDTNewsTagType)tagType{
    switch (tagType) {
        caseYDTNewsTagTypeTopic:
            self.hidden = false;
            self.tagTitleLabel.text = @"话题";
            self.tagTitleLabel.textColor = HEX_COLOR(0x438ADD);
            self.leftView.backgroundColor = HEX_COLOR(0x438ADD);
            self.contentView.backgroundColor = HEX_COLOR_ALPHA(0x438ADD,0.2);
            break;
        caseYDTNewsTagTypeHotPost:
            self.hidden = false;
            self.tagTitleLabel.text = @"热门";
            self.tagTitleLabel.textColor = HEX_COLOR(0xFF7A45);
            self.leftView.backgroundColor = HEX_COLOR(0xFF7A45);
            self.contentView.backgroundColor = HEX_COLOR_ALPHA(0xFF7A45,0.2);

            break;
        caseYDTNewsTagTypeActivity:
            self.hidden = false;
            self.tagTitleLabel.text = @"活动";
            self.tagTitleLabel.textColor = HEX_COLOR(0xFFAD00);
            self.leftView.backgroundColor = HEX_COLOR(0xFFAD00);
            self.contentView.backgroundColor = HEX_COLOR_ALPHA(0xFFAD00,0.2);

            break;
        caseYDTNewsTagTypeDiscuss:
            self.hidden = false;
            self.tagTitleLabel.text = @"讨论";
            self.tagTitleLabel.textColor = HEX_COLOR(0x71C527);
            self.leftView.backgroundColor = HEX_COLOR(0x71C527);
            self.contentView.backgroundColor = HEX_COLOR_ALPHA(0x71C527,0.2);
            break;
        caseYDTNewsTagTypeAdvertising:
            self.hidden = false;
            self.tagTitleLabel.text = @"广告";
            self.tagTitleLabel.textColor = HEX_COLOR(0x888888);
            self.leftView.backgroundColor = HEX_COLOR(0x888888);
            self.contentView.backgroundColor = HEX_COLOR_ALPHA(0x888888,0.2);
            break;
        caseYDTNewsTagTypeCustom:
            self.hidden = false;
            self.tagTitleLabel.text = @"";
            self.tagTitleLabel.textColor = HEX_COLOR(0xFA541C);
            self.leftView.backgroundColor = HEX_COLOR(0xFA541C);
            self.contentView.backgroundColor = HEX_COLOR_ALPHA(0xFA541C,0.2);
            break;
        default:
            self.hidden = true;
            break;
    }
}
#pragma mark - Private methods

#pragma mark - Protocol conformance

#pragma mark - Setter & Getter

@end
