# YDTAdvertising
### 广告私有库
#### 导入
      1. 导入私有的pod源
      2. pod 'YDTAdvertising'
#### 使用 
      1. 创建一个YDTAdHandlerDelegate，遵守<YDTAdHandlerDelegate>.用于在上层实现显示和点击广告的事件。
      实现两个代理方法
      ```
          -(void)showWithAdModel:(YDTAdModel *)adModel{
              NSLog(@"showWithAdModel=================%@",adModel);
          }

          -(void)clickedWithAdModel:(YDTAdModel *)adModel{
             NSLog(@"clickedWithAdModel=================%@",adModel);
          }
      ```
      2.导入头文件```#import "AdHeader.h"```
      3. 配置启动项，及必要属性
          - YDTADHANDLER.delegate = [YDTAdHandlerDelegate sharedInstance];
          @property (nonatomic, strong) NSString *gdtAppId; /**< 广点通ID */
          @property (nonatomic, strong) NSString *inmobiPlacementID; /**< Inmobi */
          @property (nonatomic, strong) NSString *userHost; /**< 用户域名 */
          @property (nonatomic, strong) NSString *luomiKey; /**< luomiKey */
          @property (nonatomic,   weak) id <AdvertisingDelegate> delegate;
      4. 请求广告
          [YDTADHANDLER getAdDataWithADKey:@""  complete:^(NSError *error, NSArray<YDTAdModel *> *adModelArray) {
              NSLog(@"%@",adModelArray);
              self.admodel = adModelArray.firstObject;
          }];
      5. 通过广告获得对应的视图
          YDTAdvertisingView *adView = [YDTADHANDLER getYDTAdvertisingViewWithAdModel:self.admodel type:A8AdvertisingViewTypeLargeImageWithTitle];
          adView.frame =CGRectMake(100, 100, 200, 100);
          [adView setAdvertisingClicked:^{
              [YDTADHANDLER adClickedWithAdModel:self.admodel];
          }];
          [self.view addSubview:adView];

          YDTAdvertisingCell *adCell = [YDTADHANDLER getYDTAdvertisingCellWithAdModel:self.admodel type:A8AdvertisingViewTypeLargeImageWithTitle];
          adCell.frame = CGRectMake(100, 200, 200, 100);
          [self.view addSubview:adCell];