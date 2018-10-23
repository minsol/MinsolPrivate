//
//  YDTLuomiAd.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/4/25.
//Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTLuomiAd.h"

@interface YDTLuomiAd ()

@end

@implementation YDTLuomiAd
+ (instancetype)sharedInstance{
    static YDTLuomiAd *sharedInstance = nil;
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
    NSString *adType = [NSString stringWithFormat:@"%@",adModel.sExtraDic[@"extAdType"]];
    adType = adType.length ? adType : @"";
    NSDictionary *para = @{@"z" : adType,
                           @"appkey" : self.luomiKey};
    
    [self GETHttpRequest:@"http://sdk.cferw.com/iosapi.php" param:[self addBaseParameWithParameter:para] success:^(id responseObject) {
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        if ([[dict valueForKeyPath:@"succ"] integerValue] == 1) {
            YDTLuomiAdModel *model = [YDTLuomiAdModel modelWithDictionary:dict];
            adModel.luomiAdModel = model;
            adModel.sImgUrl = model.imgurl;
            adModel.sTitle = model.wenzi;
            adModel.sDesc = @"";
        }
        if (complete) {complete();}
    } failure:^(NSError *error) {
        if (complete) {complete();}
    }];
}

- (void)showAdReportAdWithAdModel:(YDTAdModel *)adModel superView:(UIView *)superView{
    [self reportAdWithUrl:adModel.luomiAdModel.count_url httpMethodType:ADHttpMethodTypeGet];
}

-(void)clickAdActionWithAdModel:(YDTAdModel *)adModel{
    [self clickAdReportAdWithAdModel:adModel];
}

-(void)clickAdReportAdWithAdModel:(YDTAdModel *)adModel{
    [self reportAdWithUrl:adModel.luomiAdModel.click_url httpMethodType:ADHttpMethodTypeGet];
}


- (NSDictionary *)addBaseParameWithParameter:(NSDictionary *)dict {
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:dict];
    // 设备标识
    NSString *deviceId = [OpenUDID value];
    deviceId = deviceId.length ? deviceId : @"";
    [para setObject:deviceId forKey:@"deviceId"];
    NSString *width = [NSString stringWithFormat:@"%lf", [UIScreen mainScreen ].bounds.size.width];
    width = width ? width : @"";
    [para setObject:width forKey:@"sw"];
    NSString *height = [NSString stringWithFormat:@"%lf", [UIScreen mainScreen ].bounds.size.height];
    height = height ? height : @"";
    [para setObject:height forKey:@"sh"];
    NSString *osver = [UIDevice currentDevice].systemVersion;
    osver = osver ? osver : @"";
    [para setObject:osver forKey:@"osver"];
    return para;
}




@end
