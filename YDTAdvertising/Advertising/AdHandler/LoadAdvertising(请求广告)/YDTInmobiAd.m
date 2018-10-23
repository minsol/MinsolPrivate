//
//  YDTInmobiAd.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/4/24.
//Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTInmobiAd.h"

@interface YDTInmobiAd () <IMNativeDelegate>
@property (nonatomic, strong) dispatch_group_t group;

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) IMNative *nativeAd;

@end

@implementation YDTInmobiAd

+ (instancetype)sharedInstance{
    static YDTInmobiAd *sharedInstance = nil;
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
        self.placementID = @"";
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

-(void)loadTripartiteModelWithAdModel:(YDTAdModel*)adModel adkey:(NSString*)adKey complete:(void(^)(void))complete{
    dispatch_group_enter(self.group);
    self.nativeAd = [[IMNative alloc] initWithPlacementId:self.placementID.longLongValue delegate:self];
    [self.nativeAd load];
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        adModel.adIcon = self.nativeAd.adIcon;
        adModel.sTitle = self.nativeAd.adTitle;
        adModel.sDesc = self.nativeAd.adDescription;
        adModel.nativeAd = self.nativeAd;
        if (complete) {complete();}
    });
}

-(void)clickAdActionWithAdModel:(YDTAdModel *)adModel{
    [adModel.nativeAd reportAdClickAndOpenLandingPage];
}


#pragma mark - IMNativeDelegate
- (void)nativeDidFinishLoading:(IMNative *)native {
    self.nativeAd = native;
    dispatch_group_leave(self.group);
}

- (void)native:(IMNative*)native didFailToLoadWithError:(IMRequestStatus *)error {
    self.nativeAd = native;
    self.error = error;
    dispatch_group_leave(self.group);
}

/**
 * Notifies the delegate that the native ad would be presenting a full screen content.
 */
-(void)nativeWillPresentScreen:(IMNative*)native {
    
}

/**
 * Notifies the delegate that the native ad has presented a full screen content.
 */
-(void)nativeDidPresentScreen:(IMNative*)native {
    
}

/**
 * Notifies the delegate that the native ad would be dismissing the presented full screen content.
 */
-(void)nativeWillDismissScreen:(IMNative*)native {
    
}

/**
 * Notifies the delegate that the native ad has dismissed the presented full screen content.
 */
-(void)nativeDidDismissScreen:(IMNative*)native {
    
}

/**
 * Notifies the delegate that the user will be taken outside the application context.
 */
-(void)userWillLeaveApplicationFromNative:(IMNative*)native {
    
}

/**
 * Notifies the delegate that the native ad impression has been tracked
 */
-(void)nativeAdImpressed:(IMNative*)native {
    
}

/**
 * Notifies the delegate that the native ad has been interacted with.
 */
-(void)native:(IMNative*)native didInteractWithParams:(NSDictionary*)params {
    
}
/**
 * Notifies the delegate that the native ad has finished playing media.
 */
-(void)nativeDidFinishPlayingMedia:(IMNative*)native {
    
}



#pragma mark - 懒加载



@end
