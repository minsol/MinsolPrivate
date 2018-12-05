### A8FMDB 基于 FFDB 的封装 OC 版.
### 导入
      1. 导入私有的pod源
      2. pod 'A8FMDB'
### 使用
参见 Demo 里面的 Article 文件
- ArticleDatabaseAdaptor：供上层使用的管理单利
- ArticleTable ：存储的事务操作
- Article ： 模型类

#### ArticleDatabaseAdaptor 继承 DatabaseAdaptor
1. 重写 init 方法，在里面创建对应的表
2. 增加一些对表的增删改查事务操作的接口，供上层调用。实现则是调用ArticleTable的实例方法。

#### ArticleTable 继承 BaseTable
1. 重写父类的两个方法
```objc
-(void)createTable;
-(void)deleteTable;
```
2. 完成自定义的一些增删改查方法

