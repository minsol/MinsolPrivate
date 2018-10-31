//
//  AdvertisingDelegate.h
//  demo
//
//  Created by Minsol on 2018/10/22.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YDTAdModel;
@protocol AdvertisingDelegate <NSObject>
@required
-(NSString *)getAdServerIP;
-(NSDictionary *)getBaseParma;
-(NSString *)getUserHost;

-(NSString *)getGdtAppId;
-(NSString *)getInmobiPlacementID;
-(NSString *)getLuomiKey;
@optional

-(void)showWithAdModel:(YDTAdModel *)adModel;
-(void)clickedWithAdModel:(YDTAdModel *)adModel;
@end
