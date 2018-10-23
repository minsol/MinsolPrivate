//
//  YDTAdHandler.m
//  A8TV_IPhone
//
//  Created by Minsol on 2018/4/8.
//Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTAdHandler.h"

///广告的请求对象
#import "YDTInmobiAd.h"
#import "YDTLuomiAd.h"
#import "YDTGDTAd.h"
#import "YDTVoiceAd.h"
#import "YDTCorpizeAd.h"


@interface YDTAdHandler ()
@property (nonatomic, strong) dispatch_group_t group;
@property (nonatomic, strong) YDTInmobiAd *inmobiAd; /**< inmobi广告对象 */
@property (nonatomic, strong) YDTLuomiAd *luomiAd; /**< 洛米广告对象 */
@property (nonatomic, strong) YDTGDTAd *gdtAd; /**< 广点通广告对象 */
@property (nonatomic, strong) YDTCorpizeAd *corpizedAd; /**< 惠头条广告对象 */
@property (nonatomic, strong) YDTVoiceAd *voiceAd; /**< 讯飞广告对象 */

@end

@implementation YDTAdHandler

+ (instancetype)sharedInstance{
    static YDTAdHandler *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.inmobiAd = [YDTInmobiAd sharedInstance];
        self.luomiAd = [YDTLuomiAd sharedInstance];
        self.gdtAd =[YDTGDTAd sharedInstance];
        self.corpizedAd = [YDTCorpizeAd sharedInstance];
        self.voiceAd = [YDTVoiceAd sharedInstance];
        self.group = dispatch_group_create();
    }
    return self;
}

-(void)setGdtAppId:(NSString *)gdtAppId{
    self.gdtAd.gdtAppId = gdtAppId;
}

-(void)setInmobiPlacementID:(NSString *)inmobiPlacementID{
    self.inmobiAd.placementID = inmobiPlacementID;
}
-(void)setUserHost:(NSString *)userHost{
    self.voiceAd.userHost = userHost;
}
-(void)setLuomiKey:(NSString *)luomiKey{
    self.luomiAd.luomiKey = luomiKey;
}
- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - /***************************根据广告key获取广告数据*****************************/
/**
 根据广告key获取广告数据
 @param adKey 广告key
 @param complete 完成回调
 */
- (void)getAdDataWithADKey:(NSString *)adKey complete:(Complete)complete {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://test.api.a8tiyu.com/ad/query?a8id=128014351199&app=com.fungo.a8news&channel=AppStore&iVersion=4.6.0&key=A8_iOS_AD_HOME_COLLECTION&location=%E4%B8%AD%E5%9B%BD-%E5%B9%BF%E4%B8%9C%E7%9C%81-%E6%B7%B1%E5%9C%B3%E5%B8%82&platform=iOS&sign=f6bf9dbf59ba1d76e64cd6ebc555741e&time=1540183356&uid=128014351199&version=300400"]];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            //6.解析服务器返回的数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if (error) {
                error = [NSError errorWithDomain:@"数据请求错误" code:0 userInfo:nil];
                if (complete) {complete(error, nil);}return;
            }
            
            NSArray *dataArray = dict[@"data"];
            if (!dataArray || ![dataArray isKindOfClass:[NSArray class]] || dataArray.count <= 0) {
                error = [NSError errorWithDomain:@"数据请求错误" code:0 userInfo:nil];
                if (complete) {complete(error, nil);}return;
            }
            
            NSArray *adArray = @[[[YDTAdModel alloc] initWithDictionary:dataArray[0]]];
            if (error) {
                error = [NSError errorWithDomain:@"数据请求错误" code:0 userInfo:nil];
                if (complete) {complete(error, nil);}return;
            }

            // 根据广告列表的nType用不同的SDK拉取广告
            for (YDTAdModel *adModel in adArray) {
                [self loadTripartiteAdModelWithAdModel:adModel adkey:adKey];
            }
            dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
                NSArray *filteredAdArray = [self filterNotLoadedAdModel:adArray];
                if (complete) {complete(error, filteredAdArray);}
            });
            NSLog(@"%@",dict);
        }
    }];
    [dataTask resume];
}

///通过三方key直接拉去三方广告
- (void)getAdDataWithADModel:(YDTAdModel *)adModel adkey:(NSString*)adKey complete:(void(^)(void))complete{
    [self loadTripartiteAdModelWithAdModel:adModel adkey:adKey];
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        if (complete) {complete();}
    });
}

-(void)loadTripartiteAdModelWithAdModel:(YDTAdModel*)adModel adkey:(NSString*)adKey{
    dispatch_group_enter(self.group);
    if (adModel.nAdType.integerValue == 1) {// A8
        dispatch_group_leave(self.group);
    } else if (adModel.nAdType.intValue == 2) {//InMobi广告
        [self.inmobiAd loadTripartiteModelWithAdModel:adModel adkey:adKey complete:^{
            dispatch_group_leave(self.group);
        }];
    } else if (adModel.nAdType.integerValue == 3) {// 广点通广告
        [self.gdtAd loadTripartiteModelWithAdModel:adModel adkey:adKey complete:^{
            dispatch_group_leave(self.group);
        }];
    } else if (adModel.nAdType.integerValue == 4) {// 洛米广告
        [self.luomiAd loadTripartiteModelWithAdModel:adModel adkey:adKey complete:^{
            dispatch_group_leave(self.group);
        }];
    } else if (adModel.nAdType.integerValue == 5) {//惠头条广告
        [self.corpizedAd loadTripartiteModelWithAdModel:adModel adkey:adKey complete:^{
            dispatch_group_leave(self.group);
        }];
    } else if (adModel.nAdType.integerValue == 6) {//讯飞
        [self.voiceAd loadTripartiteModelWithAdModel:adModel adkey:adKey complete:^{
            dispatch_group_leave(self.group);
        }];
    } else {
        dispatch_group_leave(self.group);
    }
}

-(NSArray*)filterNotLoadedAdModel:(NSArray*)array{
    NSMutableArray *adArray = [array mutableCopy];
    for (YDTAdModel *adModel in array) {
        if (adModel.nAdType.intValue == 2 && !adModel.nativeAd) {//InMobi广告
            [adArray removeObject:adModel];
        } else if (adModel.nAdType.integerValue == 3 && !adModel.gdtNativeAd) {// 广点通广告
            [adArray removeObject:adModel];
        } else if (adModel.nAdType.integerValue == 4 && !adModel.luomiAdModel) {// 洛米广告
            [adArray removeObject:adModel];
        } else if (adModel.nAdType.integerValue == 5 && !adModel.corpizeModel) {// 惠头条
            [adArray removeObject:adModel];
        } else if (adModel.nAdType.integerValue == 6 && !adModel.voiceAdModel) {// 讯飞
            [adArray removeObject:adModel];
        }
    }
    return adArray;
}


#pragma mark - /***************************广告点击处理*****************************/
/**
 广告点击处理
 @param adModel 广告数据模型
 */
- (void)adClickedWithAdModel:(YDTAdModel *)adModel {
    switch (adModel.nAdType.integerValue) {
        case 2:{// inmobi
            [self.inmobiAd clickAdActionWithAdModel:adModel];
        }   break;
        case 3:{// 广点通
            [self.gdtAd clickAdActionWithAdModel:adModel];
        }   break;
        case 4:{// 洛米
            [self.luomiAd clickAdActionWithAdModel:adModel];
        }   break;
        case 5: {// 惠头条
            [self.corpizedAd clickAdActionWithAdModel:adModel];
        }   break;
        case 6: {// 讯飞
            [self.voiceAd clickAdActionWithAdModel:adModel];
        }   break;
        default:
            break;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedWithAdModel:)]){
        [self.delegate clickedWithAdModel:adModel];
    }
}

- (void)addAdvertisingClickedHandler:(id <AdvertisingDelegate>)advertisingClickedHandler{
    self.delegate = advertisingClickedHandler;
}


-(YDTAdvertisingCell*)getYDTAdvertisingCellWithAdModel:(YDTAdModel*)adModel type:(A8AdvertisingViewType)type{
   YDTAdvertisingCell* cell = [YDTAdvertisingCell initWithType:type];
    [cell setAdvertisingModel:adModel];
    [self adShowReportWithAdModel:adModel superView:cell];

    return cell;
}

-(YDTAdvertisingView*)getYDTAdvertisingViewWithAdModel:(YDTAdModel*)adModel type:(A8AdvertisingViewType)type{
    YDTAdvertisingView *view = [YDTAdvertisingView initWithType:type];
    [view setAdvertisingModel:adModel];
    [self adShowReportWithAdModel:adModel superView:view];
    return view;
}

#pragma mark - /*************************** 广告展示上报处理*****************************/
/**
 广告展示上报处理
 @param adModel 广告数据模型
 @param superView superView
 */
- (void)adShowReportWithAdModel:(YDTAdModel *)adModel superView:(UIView *)superView {
    switch (adModel.nAdType.integerValue) {
        case 2: {// inmobi
        }   break;
        case 3: {// 广点通
            [self.gdtAd showAdReportAdWithAdModel:adModel superView:superView];
        }   break;
        case 4: {// 洛米
            [self.luomiAd showAdReportAdWithAdModel:adModel superView:superView];
        }   break;
        case 5: {// 惠头条
            [self.corpizedAd showAdReportAdWithAdModel:adModel superView:superView];
        }   break;
        case 6: {// 讯飞
            [self.voiceAd showAdReportAdWithAdModel:adModel superView:superView];
        }   break;
        default:
            break;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(showWithAdModel:)]){
        [self.delegate showWithAdModel:adModel];
    }
}

@end