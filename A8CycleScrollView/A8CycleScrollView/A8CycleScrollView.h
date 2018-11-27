//
//  A8CycleScrollView.h
//  A8CycleScrollView
//
//  Created by Minsol on 2018/11/26.
//  Copyright © 2018 A8. All rights reserved.
//


#import <UIKit/UIKit.h>

@class A8CycleScrollView;
@protocol A8CycleScrollViewDelegate <NSObject>
@optional
/** 点击图片回调 */
- (void)cycleScrollView:(A8CycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

// ========== 轮播自定义cell ==========
/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)customCollectionViewCellClassForCycleScrollView:(A8CycleScrollView *)view;
/** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(A8CycleScrollView *)view;

// ========== 轮播自定义FlowLayout ==========
/** 如果你需要自定义UICollectionViewFlowLayout样式，请在实现此代理方法
    注意如果不是整屏的翻页：自定义UICollectionViewFlowLayout 需要实现一个方法
    -(NSNumber *)getPageWidth;
 */
-(UICollectionViewFlowLayout*)customCollectionViewFlowLayoutForCycleScrollView:(A8CycleScrollView *)view;
@end

@interface A8CycleScrollView : UIView

/** 初始轮播图（推荐使用） */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<A8CycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage;


//////////////////////  数据源API //////////////////////

/** 网络图片 url string 数组 */
@property (nonatomic, strong) NSArray *imageURLStringsGroup;

/** 每张图片对应要显示的文字数组 */
@property (nonatomic, strong) NSArray *titlesGroup;


//////////////////////  滚动控制API //////////////////////

/** 自动滚动间隔时间,默认4s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

/** 是否无限循环,默认Yes */
@property (nonatomic,assign) BOOL infiniteLoop;

/** 是否自动滚动,默认Yes */
@property (nonatomic,assign) BOOL autoScroll;

/** 占位图，用于网络未加载到图片时 */
@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, weak) id<A8CycleScrollViewDelegate> delegate;

/** block方式监听点击 */
@property (nonatomic, copy) void (^clickItemOperationBlock)(NSInteger currentIndex);

/** block方式监听滚动 */
@property (nonatomic, copy) void (^itemDidScrollOperationBlock)(NSInteger currentIndex);


@end
