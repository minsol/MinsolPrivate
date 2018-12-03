# YDTAdvertising
### 广告私有库
#### 导入
1. 导入私有的pod源
2. pod 'YDTAdvertising'
#### 使用 
1. 创建一个YDTAdHandlerDelegate，遵守<YDTAdHandlerDelegate>.用于在上层实现显示和点击广告的事件。
实现相关代理方法
```objc
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
```
2. 导入头文件
```objc
    #import "AdHeader.h"
```
3. 请求广告
```objc
[YDTADHANDLER getAdDataWithADKey:@""  complete:^(NSError *error, NSArray<YDTAdModel *> *adModelArray) {
    NSLog(@"%@",adModelArray);
}];

```

4. 通过广告获得对应的视图\
```objc
    YDTAdvertisingView *adView = [YDTADHANDLER getYDTAdvertisingViewWithAdModel:self.admodel type:A8AdvertisingViewTypeLargeImageWithTitle];
    adView.frame =CGRectMake(100, 100, 200, 100);
    [adView setAdvertisingClicked:^{
    [YDTADHANDLER adClickedWithAdModel:self.admodel];
    }];
    [self.view addSubview:adView];

    YDTAdvertisingCell *adCell = [YDTADHANDLER getYDTAdvertisingCellWithAdModel:self.admodel type:A8AdvertisingViewTypeLargeImageWithTitle];
    adCell.frame = CGRectMake(100, 200, 200, 100);
    [self.view addSubview:adCell];
```


