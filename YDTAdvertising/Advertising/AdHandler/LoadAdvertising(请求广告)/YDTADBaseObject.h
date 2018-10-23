//
//  YDTADBaseObject.h
//  A8TV_IPhone
//
//  Created by Minsol on 2018/6/21.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenUDID.h"
#import <AdSupport/AdSupport.h>
#import "YDTAdModel.h"
#define IS_IPHONE    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

typedef NS_ENUM(NSInteger, ADHttpMethodType) {
    ADHttpMethodTypePost, /**< Post */
    ADHttpMethodTypeGet  /**< Get */
};


///API类广告请求的基类
@interface YDTADBaseObject : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong) NSString *userHost; /**< 讯飞请求参数里面需要ip */

/**
 加载三方广告

 @param adModel A8后台广告
 @param adKey inmobi需要的key
 @param complete 回调
 */
-(void)loadTripartiteModelWithAdModel:(YDTAdModel*)adModel adkey:(NSString*)adKey complete:(void(^)(void))complete;

- (void)showAdReportAdWithAdModel:(YDTAdModel*)adModel superView:(UIView *)superView;
- (void)clickAdActionWithAdModel:(YDTAdModel*)adModel;
- (void)clickAdReportAdWithAdModel:(YDTAdModel*)adModel;

- (void)reportAdWithUrl:(NSString *)str httpMethodType:(ADHttpMethodType)type;
- (void)POSTHttpRequest:(NSString *)urlString
                  param:(NSDictionary *)param
                success:(void(^)(id responseObject))success
                failure:(void(^)(NSError *error))failure;
- (void)GETHttpRequest:(NSString *)urlString
                  param:(NSDictionary *)param
                success:(void(^)(id responseObject))success
                failure:(void(^)(NSError *error))failure;

- (BOOL)isPortrait;
-(NSString *)deviceName;
@end
