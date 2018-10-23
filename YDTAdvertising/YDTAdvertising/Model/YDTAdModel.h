//
//  YDTAdModel.h
//  A8TV_IPhone
//
//  Created byMinsol on 2017/9/6.
//  Copyright © 2017年 New Sense Networks Technology Co., Ltd.. All rights reserved.
//

#import "YDTAdBaseModel.h"
#import "YDTLuomiAdModel.h"
#import "GDTNativeAd.h"
#import "YDTCorpizeAdModel.h"
#import "YDTVoiceAdModel.h"
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

@class IMNative;
@class GDTNativeAdData;

@interface YDTAdModel : YDTAdBaseModel

@property (nonatomic, copy) NSString *nId;
@property (nonatomic, copy) NSString *nType;/**< 0 ：无跳转 1：下载APP 2：内部H5 3：外部H5 4： Inmobi 5：小爱广告 6：广点通 998：首页红包 999：首页彩券*/
@property (nonatomic, copy) NSString *nAdType; /**< 广告类型 1-A8 2-inmobi 3-广点通 4-洛米广告 5-惠头条广告 6-讯飞广告*/
@property (nonatomic, copy) NSString *nJumpType; /**< 跳转类型 0-无跳转 1-下载应用 2-应用内跳转H5 3-应用外跳转H5 4-inmobi 5-小爱跳转 */
@property (nonatomic, copy) NSString *nDspIndex; /**< 排序 */
@property (nonatomic, copy) NSString *sKey; /**< 广告位 */
@property (nonatomic, copy) NSString *sTitle;
@property (nonatomic, copy) NSString *sDesc;
@property (nonatomic, copy) NSString *sImgUrl;
@property (nonatomic, copy) NSString *sJumpUrl;
@property (nonatomic, copy) NSString *sVideoUrl;
@property (nonatomic, copy) NSString *sPromotedAppJump;
@property (nonatomic, copy) NSString *sPromotedAppActivity;
@property (nonatomic, copy) NSString *sPromotedAppId; /**< 推广的 AppID */
@property (nonatomic, copy) NSString *sExtra; /**< 三方额外的信息 */
@property (nonatomic, copy) NSDictionary *sExtraDic; /**< 三方额外的信息 */

@property (nonatomic, assign) A8AdvertisingViewType showType; /**< 广告显示样式 */

@property (nonatomic, copy) NSString *isLoveShowAD; /**< 是否是小爱广告 1-是 0-不是 */
@property (nonatomic, copy) NSString *jumpType; /**< 跳转类型 0-下载应用 1-跳转随机房间 2-跳转tab */
@property (nonatomic, copy) NSString *rid; /**< 小爱跳转随机主播间房间号 */

@property (nonatomic, assign) BOOL a8AdReport; /**< A8展示上报 */

@property (nonatomic, strong) IMNative *nativeAd;//  InMobi广告传递字段
@property (nonatomic, strong) UIImage  *adIcon;//

@property (nonatomic, strong) YDTLuomiAdModel *luomiAdModel; /**< 洛米广告数据模型 */

@property (nonatomic, strong) GDTNativeAd *gdtNativeAd; /**< 广点通原生自渲染数据 */
@property (nonatomic, strong) NSArray<GDTNativeAdData *> *nativeAdDataArray; /**< 广点通原生自渲染 */

@property (nonatomic, strong) YDTCorpizeAdModel *corpizeModel; /**< 惠头条广告*/

@property (nonatomic, strong) YDTVoiceAdModel *voiceAdModel; /**< 讯飞广告*/
@property (nonatomic, assign) CGFloat adHeight;
@end
