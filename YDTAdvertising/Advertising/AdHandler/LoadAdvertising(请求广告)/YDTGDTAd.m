//
//  YDTGDTAd.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/5/4.
//Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTGDTAd.h"
#import "GDTNativeExpressAdView.h"

@interface YDTGDTAd () <GDTNativeExpressAdDelegete, GDTNativeAdDelegate>

@property (nonatomic, strong) dispatch_group_t group;

@property (nonatomic, strong) GDTNativeAd *nativeAd; /**< 原生广告自渲染 */
@property (nonatomic, strong) NSArray<GDTNativeAdData *> *nativeAdDatas; /**< 原生广告自渲染数据 */

@property (nonatomic, strong) NSError *error;

@end

@implementation YDTGDTAd
+ (instancetype)sharedInstance{
    static YDTGDTAd *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.group = dispatch_group_create();
        self.gdtAppId = @"";
    }
    return self;
}
- (void)dealloc {
    NSLog(@"%s", __func__);
}

-(void)loadTripartiteModelWithAdModel:(YDTAdModel*)adModel adkey:(NSString*)adKey complete:(void(^)(void))complete{
    // extAdType：原生自渲染-100 原生模板-101 开屏-102
    // extAdId: 广告key
    NSString *extAdType  = @"";
    NSString *extAdId    = @"";
    if (adModel.sExtraDic) {
        extAdType  = [NSString stringWithFormat:@"%@",adModel.sExtraDic[@"extAdType"]];
        extAdId    = [NSString stringWithFormat:@"%@",adModel.sExtraDic[@"extAdId"]];
    }
    extAdType  = extAdType.length  ? extAdType  : @"";
    extAdId    = extAdId.length    ? extAdId    : @"";
    if (extAdId.length == 0) {
        if (complete) {complete();}
        return;
    }
    dispatch_group_enter(self.group);
    self.nativeAd = [[GDTNativeAd alloc] initWithAppId:self.gdtAppId placementId:extAdId];
    self.nativeAd.delegate = self;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.nativeAd.controller =  window.rootViewController;
    [self.nativeAd loadAd:1];
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        adModel.gdtNativeAd = self.nativeAd;
        adModel.nativeAdDataArray = self.nativeAdDatas;
        if (self.nativeAdDatas.count) {
            GDTNativeAdData *adData = [adModel.nativeAdDataArray firstObject];
            adModel.sTitle = [adData.properties valueForKeyPath:GDTNativeAdDataKeyTitle];
            adModel.sDesc = [adData.properties valueForKeyPath:GDTNativeAdDataKeyDesc];
            adModel.sImgUrl = [adData.properties valueForKeyPath:GDTNativeAdDataKeyImgUrl];
        }
        if (complete) { complete();}
    });
}

- (void)showAdReportAdWithAdModel:(YDTAdModel*)adModel superView:(UIView *)superView{
    if (adModel.gdtNativeAd && adModel.nativeAdDataArray.count) {
        GDTNativeAdData *adData = [adModel.nativeAdDataArray firstObject];
        [adModel.gdtNativeAd attachAd:adData toView:superView];
    }
}

-(void)clickAdActionWithAdModel:(YDTAdModel *)adModel{
    if (adModel.gdtNativeAd  && adModel.nativeAdDataArray.count) {
        GDTNativeAdData *adData = [adModel.nativeAdDataArray firstObject];
        [adModel.gdtNativeAd clickAd:adData];
    }
}

#pragma mark - GDTNativeAdDelegate
/**
 *  原生广告加载广告数据成功回调，返回为GDTNativeAdData对象的数组
 */
- (void)nativeAdSuccessToLoad:(NSArray *)nativeAdDataArray {
    self.nativeAdDatas = [NSArray arrayWithArray:nativeAdDataArray];
    dispatch_group_leave(self.group);
}

/**
 *  原生广告加载广告数据失败回调
 */
- (void)nativeAdFailToLoad:(NSError *)error {
    self.error = error;
    dispatch_group_leave(self.group);
}

#pragma mark - 懒加载



@end
