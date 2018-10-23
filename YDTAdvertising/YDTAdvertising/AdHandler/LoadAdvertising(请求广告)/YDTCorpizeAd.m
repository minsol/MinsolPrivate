//
//  YDTCorpizeAd.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/5/14.
//Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTCorpizeAd.h"

@interface YDTCorpizeAd ()

@end

@implementation YDTCorpizeAd
+ (instancetype)sharedInstance{
    static YDTCorpizeAd *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

-(void)loadTripartiteModelWithAdModel:(YDTAdModel*)adModel adkey:(NSString*)adKey complete:(void(^)(void))complete{

    // 惠头条
    // extAdType：横幅-201 开屏-202 弹窗-203 原生信息流-207 原生三小图-208
    // extAdId: 广告ID
    // extImgType：1-icon 2-logo 3-广告大图 4-多图
    NSString *extAdType  = @"";
    NSString *extAdId    = @"";
    NSString *extImgType = @"";
    NSString *extHeight  = @"";
    NSString *extWidth   = @"";
    if (adModel.sExtraDic) {
        extAdType  = [NSString stringWithFormat:@"%@",[adModel.sExtraDic valueForKeyPath:@"extAdType"]];
        extAdId    = [NSString stringWithFormat:@"%@",[adModel.sExtraDic valueForKeyPath:@"extAdId"]];
        extImgType = [NSString stringWithFormat:@"%@",[adModel.sExtraDic valueForKeyPath:@"extImgType"]];
        extHeight  = [NSString stringWithFormat:@"%@",[adModel.sExtraDic valueForKeyPath:@"extHeight"]];
        extWidth   = [NSString stringWithFormat:@"%@",[adModel.sExtraDic valueForKeyPath:@"extWidth"]];
    }
    extAdType  = extAdType.length  ? extAdType  : @"";
    extAdId    = extAdId.length    ? extAdId    : @"";
    extImgType = extImgType.length ? extImgType : @"";
    extHeight  = extHeight.length  ? extHeight  : @"";
    extWidth   = extWidth.length   ? extWidth   : @"";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    // 参数
    [dict setValue:extAdId forKey:@"adid"]; // 广告位ID
    [dict setValue:extAdType forKey:@"adtype"]; // 广告类型 201 移动横幅 202 移动开屏 203 移动弹窗(全屏或插屏) 205 移动视频贴片 206 移动视频暂停 207 移动原生信息流 208 移动原生焦点图(3 图) 209 移动激励广告
    [dict setValue:extWidth  ? extWidth  : @"" forKey:@"width"]; // 广告位宽度
    [dict setValue:extHeight ? extHeight : @"" forKey:@"height"]; // 广告位高度
    
    [self POSTHttpRequest:@"http://adx.corpize.com/ssp/corpize" param:[self addBaseParameWithParameter:dict] success:^(NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
        NSInteger errorCode = [[responseObject valueForKeyPath:@"status"] integerValue];
        if (errorCode == 200) {
            // 广告正常
            YDTCorpizeAdModel *corpizeAdModel = [[YDTCorpizeAdModel alloc] init];
            if (extAdType.integerValue == 207 || extAdType.integerValue == 208) {
                // 解析广告原生数据
                YDTCorpizeNativeModel *nativeModel = [[YDTCorpizeNativeModel alloc] init];
                NSArray *assets = [responseObject valueForKeyPath:@"native.assets"];
                for (NSDictionary *asset in assets) {
                    NSArray *keyArray = [asset allKeys];
                    for (NSString *keyString in keyArray) {
                        if ([keyString isEqualToString:@"title"]) {
                            // 标题
                            nativeModel.titleString = [asset valueForKeyPath:@"title.text"];
                        } else if ([keyString isEqualToString:@"img"]) {
                            // 图片
                            NSDictionary *dict = [asset valueForKeyPath:@"img"];
                            NSString *imageType = [NSString stringWithFormat:@"%@", [dict valueForKeyPath:@"type"]];
                            if ([imageType isEqualToString:extImgType]) {
                                nativeModel.imageArray = [dict valueForKeyPath:@"url"];
                            }
                        } else if ([keyString isEqualToString:@"data"]) {
                            // 描述
                            NSDictionary *dict = [asset valueForKeyPath:@"data"];
                            if ([[dict valueForKeyPath:@"label"] isEqualToString:@"desc"]) {
                                nativeModel.desc = [dict valueForKeyPath:@"value"];
                            }
                        }
                    }
                }
                // 上报数据
                nativeModel.imptrackers = [responseObject valueForKeyPath:@"native.imptrackers"];
                // 点击上报
                NSDictionary *link = [responseObject valueForKeyPath:@"native.link"];
                nativeModel.linkModel = [YDTCorpizeNativeLinkModel modelWithDictionary:link];
                corpizeAdModel.nativeModel = nativeModel;
            } else if ([responseObject valueForKeyPath:@"ext"]) {
                NSDictionary *dict = [responseObject valueForKey:@"ext"];
                YDTCorpizeExtModel *extModel = [YDTCorpizeExtModel modelWithDictionary:dict];
                corpizeAdModel.extModel = extModel;
            }
            
            if (corpizeAdModel) {
                adModel.corpizeModel = corpizeAdModel;
                if (corpizeAdModel.nativeModel) {
                    adModel.sTitle = corpizeAdModel.nativeModel.titleString;
                    adModel.sDesc = corpizeAdModel.nativeModel.desc;
                    adModel.sImgUrl = [corpizeAdModel.nativeModel.imageArray firstObject];
                } else if (corpizeAdModel.extModel) {
                    adModel.sTitle = corpizeAdModel.extModel.titleString;
                    adModel.sDesc = corpizeAdModel.extModel.descString;
                    adModel.sImgUrl = corpizeAdModel.extModel.iurl;
                }
            }
        }
        if (complete) {complete();}
    } failure:^(NSError *error) {
        if (complete) {complete();}
    }];
}

- (void)showAdReportAdWithAdModel:(YDTAdModel*)adModel superView:(UIView *)superView{
    if (adModel.corpizeModel) {
        if (adModel.corpizeModel.nativeModel) {
            for (NSString *reportString in adModel.corpizeModel.nativeModel.imptrackers) {
                [self reportAdWithUrl:reportString httpMethodType:ADHttpMethodTypePost];
            }
        } else if (adModel.corpizeModel.extModel) {
            for (NSString *reportString in adModel.corpizeModel.extModel.imptrackers) {
                [self reportAdWithUrl:reportString httpMethodType:ADHttpMethodTypePost];
            }
        }
    }
}

-(void)clickAdActionWithAdModel:(YDTAdModel *)adModel{
    if (adModel.corpizeModel) {
        if (adModel.corpizeModel.nativeModel) {
            YDTCorpizeNativeLinkModel *linkModel = adModel.corpizeModel.nativeModel.linkModel;
            [self corpizedModelClickedWithUrl:linkModel.url action:linkModel.action];
        } else if (adModel.corpizeModel.extModel) {
            [self corpizedModelClickedWithUrl:adModel.corpizeModel.extModel.clickurl action:adModel.corpizeModel.extModel.action];
        }
    }
    [self clickAdReportAdWithAdModel:adModel];
}
/**
 惠头条广告点击事件
 
 @param url 跳转地址
 @param action 曹邹
 */
- (void)corpizedModelClickedWithUrl:(NSString *)url action:(NSString *)action {
    
}

- (void)clickAdReportAdWithAdModel:(YDTAdModel*)adModel{
    
}


- (NSDictionary *)addBaseParameWithParameter:(NSDictionary *)para {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:para];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 公共参数
    [dict setValue:@"20170518" forKey:@"version"]; // 协议版本号,目前版本号为 20170518
    [dict setValue:@"0" forKey:@"dnt"]; // 是否不允许广告追踪,0 – 允许追踪,1 – 不允许追踪
    [dict setValue:@"https://itunes.apple.com/cn/app/a8%E4%BD%93%E8%82%B2%E6%96%B0%E9%97%BB/id1369712497?mt=8" forKey:@"storeurl"]; // APP应用市场下载链接
    [dict setValue:@"1" forKey:@"pos"]; // 广告位在屏幕的第N屏
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    [dict setValue:bundleId forKey:@"bundle"]; // bundleID
    NSString *appName = [infoDictionary valueForKeyPath:@"CFBundleDisplayName"];
    [dict setValue:appName forKey:@"appname"]; // AppName
    NSMutableString *userAgent = [NSMutableString stringWithString:[[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]];
    [dict setValue:userAgent forKey:@"ua"]; // APP 端 User Agent 信息
    NSString *devicetype = IS_IPHONE ? @"4" : @"5";
    [dict setValue:devicetype forKey:@"devicetype"]; // 设备类型
    NSString *os = IS_IPHONE ? @"iOS" : @"iPad";
    [dict setValue:os forKey:@"os"]; // 手机系统
    [dict setValue:[[UIDevice currentDevice] systemVersion] forKey:@"osv"]; // 手机系统版本
    NSString *ipAddress = [NSString stringWithFormat:@"%@",self.userHost];
    [dict setValue:ipAddress forKey:@"ip"]; // IP地址
    [dict setValue:@"apple" forKey:@"make"]; // 设备执照厂商
    [dict setValue:[self deviceName] forKey:@"model"]; // 设备型号
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    languageName = languageName.length ? languageName : @"";
    [dict setValue:languageName forKey:@"language"]; // 设备语言
    [dict setValue:@"0" forKey:@"js"];
    [dict setValue:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] forKey:@"idfa"];
    NSString *orientation = [self isPortrait] ? @"0" : @"1";
    [dict setValue:orientation forKey:@"orientation"]; // 屏幕方向 0 – 竖向 1 – 横行
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    NSString *width = [NSString stringWithFormat:@"%lf", size_screen.width * scale_screen];
    NSString *height = [NSString stringWithFormat:@"%lf", size_screen.height * scale_screen];
    [dict setValue:width forKey:@"sw"];
    [dict setValue:height forKey:@"sh"];
    return dict;
}

@end
