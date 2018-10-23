//
//  A8AdvertisingView.h
//  A8TV_IPhone
//
//  Created by Minsol on 2018/7/10.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDTNewsTagView.h"
#import "YDTAdModel.h"
/*
 ///使用位置说明
 左图右文:
 首页信息流
 
 大图样式带标题:
 首页信息流
 
 左图右文带按钮:
 竞彩文章底部的“一键购cai”
 
 大图样式无标题:
 新闻底部banner
 */
typedef NS_ENUM(NSInteger, A8AdvertisingViewType) {
    A8AdvertisingViewTypeLeftImage, /**< 左图右文 */
    A8AdvertisingViewTypeLargeImageWithTitle,/**< 大图样式带标题 */
    A8AdvertisingViewTypeLeftImageRightButton,/**< 左图右文带按钮 */
    A8AdvertisingViewTypeLargeImage,/**< 大图样式无标题 */
};

@interface YDTAdvertisingView : UIView

@property (nonatomic,strong) UIView         *contentView; /**< 内容视图 */
@property (nonatomic,strong) UIImageView    *advertisingImage; /**< 广告图片 */
@property (nonatomic,strong) UILabel        *advertisingTitle; /**< 广告标题 */
@property (nonatomic,strong) UILabel        *advertisingSubTitel;/**< 广告副标题 */
@property (nonatomic,strong)YDTNewsTagView *advertisingTagView; /**< 广告推广标签 */
@property (nonatomic,strong) UIView         *bottomLineView; /**< 底部分割线 */

@property (nonatomic,strong) YDTAdModel     *advertisingModel;/**<  广告数据 */

@property(nonatomic,copy) void(^advertisingClicked)(void); /**< 点击回调 */

+(id)initWithType:(A8AdvertisingViewType)advertisingType;
-(instancetype)initWithType:(A8AdvertisingViewType)advertisingType;
-(void)setUpConstraints;
-(void)updateSubViewsConstraintsIfNeeded;
@end
