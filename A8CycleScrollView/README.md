# A8HttpMessage
### 广告私有库
#### 导入
      1. 导入私有的pod源
      2. pod 'A8HttpMessage'
#### 使用
        1. 创建HttpMessageXXX继承HttpMessageBase；
        2. 创建HttpMessageXXX实例的时候进行必要的赋值；
        ```
        @property (nonatomic, strong) NSString  *urlHost;
        @property (nonatomic, strong) NSString  *path;
        @property (nonatomic, assign) YDTNetworkMethod  method;
        @property (nonatomic, strong) NSDictionary *param;
        ```
        3. 使用[HttpMessageCenter sharedManager]调用sendMessage方法；
        4.之后就可以在HttpMessageXXX实例的responseObject解析数据。

