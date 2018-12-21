# AppRoutes
### [依赖地址](https://github.com/joeldev/JLRoutes)
### 用于全局路由
#### 步骤一 导入 AppDelegate+RegisterRoute
#### 步骤二 配置 URL Types
#### 步骤三 注册
```objc
    [self registerRouteWithScheme:Scheme];
```
#### 步骤四 处理 APP 回调
```objc
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    if ([[url.scheme lowercaseString] isEqualToString:[RouteDemo lowercaseString]]) {
        return [[JLRoutes routesForScheme:RouteDemo] routeURL:url];
    }
    return true;
}
```
#### 步骤五 打开任意界面
```objc
    ///Scheme://style/controller----> Scheme://push/controllerName?key1=value1&key2=value2
    NSString *url = @"Scheme://push/controllerName?key1=value1&key1=value2";
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate openURLString:url];
```
🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺🍺

### Safari 唤起 APP
#### 配置 LSApplicationQueriesSchemes
#### safari 浏览器输入 Scheme://push/controllerName?key1=value1&key1=value2
