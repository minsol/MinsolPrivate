//
//  YDTAdHandler.h
//  A8TV_IPhone
//
//  Created by Minsol on 2018/4/8.
//Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AdvertisingDelegate.h"
#import "YDTAdvertisingCell.h"//后面会引入所有View头文件及YDTAdModel.h


typedef void(^Complete)(NSError *error, NSArray<YDTAdModel *> *adModelArray);

/// 广告
@interface YDTAdHandler : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSString *gdtAppId; /**< 广点通ID */
@property (nonatomic, strong) NSString *inmobiPlacementID; /**< Inmobi */
@property (nonatomic, strong) NSString *userHost; /**< 用户域名 */
@property (nonatomic, strong) NSString *luomiKey; /**< luomiKey */
@property (nonatomic,   weak) id <AdvertisingDelegate> delegate;


///通过adkey获取A8后台广告数据
- (void)getAdDataWithADKey:(NSString *)adKey complete:(Complete)complete;
///通过三方key直接拉去三方广告
- (void)getAdDataWithADModel:(YDTAdModel *)adModel adkey:(NSString*)adKey complete:(void(^)(void))complete;
///广告点击
- (void)adClickedWithAdModel:(YDTAdModel *)adModel;
///通过广告获取对应的cell
-(YDTAdvertisingCell *)getYDTAdvertisingCellWithAdModel:(YDTAdModel*)adModel type:(A8AdvertisingViewType)type;
///通过广告获取对应的View
-(YDTAdvertisingView *)getYDTAdvertisingViewWithAdModel:(YDTAdModel*)adModel type:(A8AdvertisingViewType)type;
@end

