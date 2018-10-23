//
// YDTAdvertisingCellLeftImage.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/8/3.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTAdvertisingCellLeftImage.h"

@implementation YDTAdvertisingCellLeftImage

#pragma mark - Life cycle

#pragma mark - Config views

- (void)loadSubviews {
    self.advertisingView = [YDTAdvertisingView initWithType:A8AdvertisingViewTypeLeftImage];
    [self.contentView addSubview:self.advertisingView];
}

#pragma mark - Actions

#pragma mark - Public methods

#pragma mark - Private methods

#pragma mark - Protocol conformance

#pragma mark - Setter & Getter

@end
