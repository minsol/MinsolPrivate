//
//  YDTVoiceAd.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/6/20.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTVoiceAd.h"
#import "YDTVoiceAdModel.h"
#import "AdHeader.h"
#import "YDTAdNetWorkManager.h"

@implementation YDTVoiceAd

+ (instancetype)sharedInstance{
    static YDTVoiceAd *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)loadTripartiteModelWithAdModel:(YDTAdModel*)adModel adkey:(NSString*)adKey complete:(void(^)(void))complete{
    // 讯飞  * 备注里填入：{"extAdId":"fe26ec5023ae52f0c0abcfad8b9621c8","extHeight":"300","extWidth":"600"}
    // extAdId: 广告ID
    // extHeight：
    // extWidth：
    NSString *extAdId    = @"";
    NSString *extHeight  = @"";
    NSString *extWidth   = @"";
    if (adModel.sExtraDic) {
        extAdId    = [NSString stringWithFormat:@"%@",[adModel.sExtraDic valueForKeyPath:@"extAdId"]];
        extHeight  = [NSString stringWithFormat:@"%@",[adModel.sExtraDic valueForKeyPath:@"extHeight"]];
        extWidth   = [NSString stringWithFormat:@"%@",[adModel.sExtraDic valueForKeyPath:@"extWidth"]];
    }
    extAdId    = extAdId.length    ? extAdId    : @"";
    extHeight  = extHeight.length  ? extHeight  : @"";
    extWidth   = extWidth.length   ? extWidth   : @"";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:extAdId forKey:@"adunitid"]; // 讯飞广告平台 注册广告位 ID
    [dict setValue:extWidth forKey:@"adw"]; // 宽度
    [dict setValue:extHeight forKey:@"adh"]; // 高度
    
    [self POSTHttpRequest:@"http://ws.voiceads.cn/ad/request" param:[self addBaseParameWithParameter:dict] success:^(NSDictionary *responseObject) {
        YDTVoiceAdModel *voiceAdModel = [[YDTVoiceAdModel alloc]initWithDictionary:responseObject];
        NSInteger errorCode = [voiceAdModel.rc integerValue];
        if (errorCode == 70200) {
            if (voiceAdModel) {
                adModel.voiceAdModel = voiceAdModel;
                if (voiceAdModel.batch_ma.count) {
                    YDTVoiceModel *model = voiceAdModel.batch_ma.firstObject;
                    adModel.sTitle = model.title;
                    adModel.sDesc = model.sub_title;
                    adModel.sImgUrl = model.image;
                }
            }
        }
        if (complete) {complete();}
    } failure:^(NSError *error) {
        if (complete) {complete();}
    }];
}

- (void)showAdReportAdWithAdModel:(YDTAdModel*)adModel superView:(UIView *)superView{
    if (adModel.voiceAdModel) {
        NSString *impressString = [NSString stringWithFormat:@"impress%@",adModel.voiceAdModel.sessionid];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:impressString]) {
            return;
        }
        if (adModel.voiceAdModel.batch_ma.count) {
            YDTVoiceModel *model = adModel.voiceAdModel.batch_ma.firstObject;
            for (NSString *reportString in model.impr_url) {
                [self reportAdWithUrl:reportString httpMethodType:ADHttpMethodTypeGet];
                [[NSUserDefaults standardUserDefaults] setBool:true forKey:impressString];
            }
        }
    }
}

-(void)clickAdActionWithAdModel:(YDTAdModel *)adModel{
    [self clickAdReportAdWithAdModel:adModel];
}

- (void)clickAdReportAdWithAdModel:(YDTAdModel*)adModel{
    NSString *clickString = [NSString stringWithFormat:@"click%@",adModel.voiceAdModel.sessionid];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:clickString]) {
        return;
    }
    if (adModel.voiceAdModel) {
        if (adModel.voiceAdModel.batch_ma.count) {
            YDTVoiceModel *model = adModel.voiceAdModel.batch_ma.firstObject;
            for (NSString *reportString in model.click_url) {
                [self reportAdWithUrl:reportString httpMethodType:ADHttpMethodTypeGet];
                [[NSUserDefaults standardUserDefaults] setBool:true forKey:clickString];
            }
        }
    }
}
-(void)GETHttpRequest:(NSString *)urlString param:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    YDTAdNetWorkManager *manager = [YDTAdNetWorkManager sharedManager];
    [manager addCookie];
    [manager addUserAgent];
    [manager GET:urlString
      parameters:param
         success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
             if (success) {
                 success(responseObject);
             }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
             if (failure) {
                 failure(error);
             }
         }];
}

- (NSDictionary *)addBaseParameWithParameter:(NSDictionary *)para {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:para];
    // 公共参数
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    [dict setValue:@"json" forKey:@"tramaterialtype"]; // 下游需要的普 通广告的物料 格式
    [dict setValue:@"1.4.6" forKey:@"api_ver"]; // 协议号
    [dict setValue:@"1" forKey:@"is_support_deeplink"]; // 媒体是否支持deeplink
    [dict setValue:@"3" forKey:@"secure"]; // 媒体支持的 http 协议类型
    NSString *devicetype = IS_IPHONE ? @"0" : @"1";
    [dict setValue:devicetype forKey:@"devicetype"]; // 设备类型
    [dict setValue:@"iOS" forKey:@"os"]; // 手机系统
    [dict setValue:[[UIDevice currentDevice] systemVersion] forKey:@"osv"]; // 手机系统版本
    [dict setValue:[OpenUDID value] forKey:@"openudid"]; // OpenUDID
    [dict setValue:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] forKey:@"idfa"];///idfa
    [dict setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"idfv"];///idfv
    
    [dict setValue:[NSString stringWithFormat:@"%lf",[UIScreen mainScreen].scale] forKey:@"density"]; //屏幕密度
    [dict setValue:@"46000" forKey:@"operator"]; //网络运营商
    [dict setValue:@"6" forKey:@"net"]; //   联网类型
    NSString *ipAddress = [NSString stringWithFormat:@"%@",self.userHost];
    [dict setValue:ipAddress forKey:@"ip"]; // IP地址
    
    NSMutableString *userAgent = [NSMutableString stringWithString:[[UIWebView new] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]];
    [dict setValue:userAgent forKey:@"ua"]; // APP 端 User Agent 信息
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;//精确到毫秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    [dict setValue:timeString forKey:@"ts"]; // 发送请求时的本地 UNIX 时间戳
    
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    NSString *width = [NSString stringWithFormat:@"%lf", size_screen.width * scale_screen];
    NSString *height = [NSString stringWithFormat:@"%lf", size_screen.height * scale_screen];
    [dict setValue:width forKey:@"dvw"];
    [dict setValue:height forKey:@"dvh"];
    NSString *orientation = [self isPortrait] ? @"0" : @"1";
    [dict setValue:orientation forKey:@"orientation"]; // 屏幕方向 0 – 竖向 1 – 横行
    [dict setValue:@"Apple" forKey:@"vendor"]; // 屏幕方向 0 – 竖向 1 – 横行
    [dict setValue:[self deviceName] forKey:@"model"]; // 设备型号
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    languageName = languageName.length ? languageName : @"";
    [dict setValue:languageName forKey:@"lan"]; // 设备语言
    [dict setValue:@"0" forKey:@"brk"]; // iOS 设备是否越狱
    [dict setValue:@"0" forKey:@"isboot"]; // 是否开屏
    [dict setValue:@"1" forKey:@"batch_cnt"]; // 是否开屏
    
    
    [dict setValue:@"5b14b8f3" forKey:@"appid"]; // appid
    NSString *appName = [infoDictionary valueForKeyPath:@"CFBundleDisplayName"];
    [dict setValue:appName forKey:@"appname"]; // AppName
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [dict setValue:version forKey:@"appver"]; // AppVersion
    [dict setValue:@"com.fungo.a8news" forKey:@"pkgname"]; // AppName
    return dict;
}

@end
