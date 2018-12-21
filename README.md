### MinsolPrivate
用于放置私有库源文件

### 使用方法
1. 在本地添加 Cocoapods 的私有仓库
```objc
    pod repo add MinsolSpec https://github.com/minsol/MinsolSpec.git
```
注意是私有Cocoapods的仓库，不是源代码的那个仓库。

2. 将本地调试好的 podspec 推送到私有仓库
```objc
    pod repo push MinsolSpec xxxx.podspec --allow-warnings --use-libraries
```
3. 在工程的 Podfile 中添加私有库地址。
```objc
    source 'https://github.com/CocoaPods/Specs.git'# CocoaPods 官方库
    source 'https://github.com/minsol/MinsolSpec.git'# 私有库
    target '项目target名' do
        pod '组件库名'
    end
```
4. 更新
```objc
    pod update --verbose --no-repo-update
```
5. Author
- Name : Minsol
- Email : minsol0421@163.com
