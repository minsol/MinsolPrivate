//
//  YDTLuomiAdModel.h
//  A8TV_IPhone
//
//  Created by Minsol on 2018/4/25.
//Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTBaseModel.h"

/// 洛米广告模型
@interface YDTLuomiAdModel : YDTBaseModel

#pragma mark - Property

@property (nonatomic, assign) BOOL report; /**< 是否经过上报 */
@property (nonatomic, copy) NSString *click_url; /**< 广告点击回调地址 */
@property (nonatomic, copy) NSString *count_url; /**< 广告展示成功回调地址 */
@property (nonatomic, copy) NSString *edown_url; /**< 下载类广告,结束下载时回调。(dev_time:本地时间戳，单位秒) */
@property (nonatomic, copy) NSString *finish_url; /**< 下载类广告,完成安装时回调。(dev_time:本地时间戳，单位秒，packageName：安装包名) */
@property (nonatomic, copy) NSString *getImageTJ; /**< <#describe#> */
@property (nonatomic, copy) NSString *gotourl; /**< 点击跳转地址 */
@property (nonatomic, copy) NSString *height; /**< 图片高度 */
@property (nonatomic, copy) NSString *imgurl; /**< 图片地址 */
@property (nonatomic, copy) NSString *ip; /**< IP地址 */
@property (nonatomic, copy) NSString *is_link; /**< 1：是落地页 2：直连 */
@property (nonatomic, copy) NSString *key; /**< 应用唯一标识 */
@property (nonatomic, copy) NSString *mediaid; /**< <#describe#> */
@property (nonatomic, copy) NSString *planid; /**< <#describe#> */
@property (nonatomic, copy) NSString *sdown_url; /**< 下载类广告，开始下载时回调dev_time:本地时间戳，单位秒 */
@property (nonatomic, copy) NSString *succ; /**< 1：成功0：失败 */
@property (nonatomic, copy) NSString *wenzi; /**< 文字 */
@property (nonatomic, copy) NSString *width; /**< 图片宽度 */
@property (nonatomic, copy) NSString *code; /**<
                                             no data    表示z为空或者没有传
                                             no zone    表示z的值不存在
                                             no_deviceid    表示设备号缺失
                                             no_idfa    表示idfa不存在
                                             no_api    表示该开发者接入的不是api
                                             7    当前开发者不存在或者用户状态异常
                                             8    开发者下没有创建应用或者应用异常
                                             9    表示没有匹配到应用
                                             20    表示该广告类型下没有广告
                                             10    平台限制目前只能是Android或者ios
                                             11    表示限制会员
                                             12    表示限制站点
                                             13    表示限制分类
                                             14    表示经过弹出概率之后没有广告了
                                             22    表示广告限制地区
                                             16    表示广告限制流量端口 */


#pragma mark - Method

@end
