//
//  ViewController.m
//  demo
//
//  Created by Minsol on 2018/10/18.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "ViewController.h"
#import "A8CycleScrollView.h"
#import "A8CycleScrollLayout.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"新建交流QQ群：185534916 ",
                        @"disableScrollGesture可以设置禁止拖动",
                        @"感谢您的支持，如果下载的"
                        ];
    
    CGFloat w = self.view.bounds.size.width;
    
    
    // 网络加载 --- 创建带标题的图片轮播器
    A8CycleScrollView *cycleScrollView2 = [A8CycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 280, w, 180) delegate:self placeholderImage:nil];
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.delegate = self;
    [self.view addSubview:cycleScrollView2];
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
}

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



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
