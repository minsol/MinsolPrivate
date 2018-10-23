//
//  YDTCorpizeAdModel.h
//  A8TV_IPhone
//
//  Created by Minsol on 2018/5/14.
//Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTBaseModel.h"

@class YDTCorpizeNativeLinkModel, YDTCorpizeNativeModel, YDTCorpizeExtModel;

/// 惠头条广告
@interface YDTCorpizeAdModel : YDTBaseModel

#pragma mark - Property

@property (nonatomic, strong) YDTCorpizeNativeModel *nativeModel; /**< 原生广告数据类型 */
@property (nonatomic, strong) YDTCorpizeExtModel *extModel;

#pragma mark - Method

@end

@interface YDTCorpizeNativeModel : YDTBaseModel

#pragma mark - Property

@property (nonatomic, copy) NSString *titleString; /**< 标题 */
@property (nonatomic, copy) NSString *desc; /**< 描述 */
@property (nonatomic, strong) NSArray *imageArray; /**< 图片数组 */
@property (nonatomic, strong) NSArray<NSString *> *imptrackers; /**< 展示上报 */
@property (nonatomic, strong) YDTCorpizeNativeLinkModel *linkModel; /**< 点击上报模型 */

#pragma mark - Method

@end

@interface YDTCorpizeNativeLinkModel : YDTBaseModel

#pragma mark - Property

@property (nonatomic, copy) NSString *action; /**< 操作 0-未确认 1-APP WebView 2-系统浏览器 3-打开地图 4-拨打电话 5-播放视频 6-下载APP 7-deeplink链接 */
@property (nonatomic, strong) NSArray<NSString *> *clicktrackers; /**< 点击检测链接 */
@property (nonatomic, copy) NSString *url; /**< 跳转地址 */

#pragma mark - Method

@end


@interface YDTCorpizeExtModel : YDTBaseModel

#pragma mark - Property
@property (nonatomic, copy) NSString *action; /**< 操作  0-未确认 1-APP WebView 2-系统浏览器 3-打开地图 4-拨打电话 5-播放视频 6-下载APP 7-deeplink链接 */
@property (nonatomic, copy) NSString *titleString; /**< 标题 */
@property (nonatomic, copy) NSString *descString; /**< 描述 */
@property (nonatomic, copy) NSString *dfnString; /**< 应用下载链接 */
@property (nonatomic, strong) NSArray *clicktrackers; /**< 点击检测链接 */
@property (nonatomic, copy) NSString *clickurl; /**< 点击跳转链接 */
@property (nonatomic, strong) NSArray *imptrackers; /**< 上报 */
@property (nonatomic, copy) NSString *iurl; /**< 广告素材 */



#pragma mark - Method

@end
