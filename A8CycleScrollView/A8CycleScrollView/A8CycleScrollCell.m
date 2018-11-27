//
//  A8CycleScrollCell.m
//  A8CycleScrollView
//
//  Created by Minsol on 2018/11/26.
//  Copyright © 2018 A8. All rights reserved.
//


#import "A8CycleScrollCell.h"

@interface A8CycleScrollCell ()

@end

@implementation A8CycleScrollCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return self;
}


- (void)setupUI {
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.cornerRadius = 4.0f;
    // 1.图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.cornerRadius = 4;
    imageView.clipsToBounds = YES;
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    
    // 2.标题背景视图
    CGFloat height = 25;
    CGFloat width = self.bounds.size.width;
    CGFloat x = 0;
    CGFloat y = self.bounds.size.height - height;
    UIImageView *newsTitleBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    newsTitleBackgroundImageView.image = [UIImage imageNamed:@"a8_homeHot_banner_bottom"];
    [imageView addSubview:newsTitleBackgroundImageView];
    
    // 3.新闻标题
    CGFloat titleX = 4;
    CGFloat titleY = 5;
    CGFloat titleWidth = width - titleX * 2;
    CGFloat titleHeight = height - titleY - 6;
    UILabel *newsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleWidth, titleHeight)];
    newsTitleLabel.textColor = [UIColor whiteColor];
    newsTitleLabel.font = [UIFont systemFontOfSize:14];
    [newsTitleBackgroundImageView addSubview:newsTitleLabel];
    self.titleLabel = newsTitleLabel;
}


@end
