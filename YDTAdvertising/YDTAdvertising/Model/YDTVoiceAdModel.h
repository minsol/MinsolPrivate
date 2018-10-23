//
//  YDTVoiceAdModel.h
//  A8TV_IPhone
//
//  Created by Minsol on 2018/6/21.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTAdBaseModel.h"

/// 讯飞广告类型
@interface YDTVoiceAdModel : YDTAdBaseModel
@property (nonatomic, copy) NSString *adtype; /**< 广告交互类型(跳 转类、下载类、品 牌类)，redirect/download/brand */
@property (nonatomic, copy) NSString *batch_cnt; /**< 本次下发的广告 数目 */
@property (nonatomic, strong) NSArray *batch_ma; /**< 广告列表 */
@property (nonatomic, copy) NSString *info_cn; /**< 广告请求成功 */
@property (nonatomic, copy) NSString *info_en; /**< success */
@property (nonatomic, copy) NSString *is_voice_ad; /**< <#describe#> */
@property (nonatomic, copy) NSString *matype; /**< html/meta */
@property (nonatomic, copy) NSString *rc; /**< 70200 */
@property (nonatomic, copy) NSString *sessionid; /**< <#describe#> */
@end



@interface YDTVoiceModel : YDTAdBaseModel
@property (nonatomic, copy) NSString *ad_source_mark; /**< 广告来源 */
@property (nonatomic, copy) NSString *adtype; /**< 广告交互类型(跳 转类、下载类、品 牌类)，redirect/download/brand */
@property (nonatomic, strong) NSArray *click_url; /**< 点击监控数组 用户点击后触 发*/
@property (nonatomic, copy) NSString *h; /**< 高 */
@property (nonatomic, copy) NSString *image; /**< image url */
@property (nonatomic, strong) NSArray *impr_url; /**< 曝光监控数组， 广告加载完成 触发上报 */
@property (nonatomic, copy) NSString *inst_downstart_url; /**< 针对下载类广 告，下载开始上 报监控 */
@property (nonatomic, copy) NSString *inst_downsucc_url; /**< 针对下载类广 告，下载成功上 报监控 */
@property (nonatomic, copy) NSString *inst_installstart_url; /**< 针对下载类广 告，安装开始上 报监控 */
@property (nonatomic, copy) NSString *inst_installsucc_url; /**< 针对下载类广 告，安装成功上 报监控 */
@property (nonatomic, copy) NSString *landing_url; /**< 跳转 */
@property (nonatomic, copy) NSString *deep_link_url; /**< 跳转 */
@property (nonatomic, copy) NSString *protocol; /**< 视频协议类型 */
@property (nonatomic, copy) NSString *sub_title; /**< subtitle of AD */
@property (nonatomic, copy) NSString *title; /**< title of AD */
@property (nonatomic, copy) NSString *various_native_type; /**< 多样原生物料类型  2:一图一文，3:一图两文 4:一图，5:三图一文 */
@property (nonatomic, copy) NSString *voice_ad_type; /**< 语音互动广告类 型 0:非语音互动广告; */
@property (nonatomic, copy) NSString *w; /**< 宽 */




@end







