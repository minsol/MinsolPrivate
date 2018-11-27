# A8CycleScrollView
### 轮播图：参照SDCycleScrollView添加自定义UICollectionViewFlowLayout
#### 导入
      1. 导入私有的pod源
      2. pod 'A8CycleScrollView'
#### 使用
```
    // 网络加载 --- 创建带标题的图片轮播器
    A8CycleScrollView *cycleScrollView2 = [A8CycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 280, w, 180) delegate:self placeholderImage:nil];
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.delegate = self;
    [self.view addSubview:cycleScrollView2];
    
    
    #pragma mark - A8CycleScrollViewDelegate
    /*
    /** 点击图片回调 */
    - (void)cycleScrollView:(A8CycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    }
    
    //// ========== 轮播自定义cell ==========
    ///** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
    //- (Class)customCollectionViewCellClassForCycleScrollView:(A8CycleScrollView *)view{
    //    return [A8CycleScrollCell class];
    //}
    ///** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
    //- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(A8CycleScrollView *)view{
    //    NSLog(@"%@",cell);
    //}
    
    // ========== 轮播自定义FlowLayout ==========
    /** 如果你需要自定义UICollectionViewFlowLayout样式，请在实现此代理方法 */
    -(UICollectionViewFlowLayout*)customCollectionViewFlowLayoutForCycleScrollView:(A8CycleScrollView *)view{
    A8CycleScrollLayout *bannerLayout = [[A8CycleScrollLayout alloc] init];
    return bannerLayout;
    }
```

