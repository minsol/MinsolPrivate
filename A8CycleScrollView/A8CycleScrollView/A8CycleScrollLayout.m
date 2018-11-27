//
//  A8CycleScrollLayout.m
//  A8CycleScrollView
//
//  Created by Minsol on 2018/11/26.
//  Copyright © 2018 A8. All rights reserved.
//

#import "A8CycleScrollLayout.h"

#define kSpacing 50
#define kMargin 8
#define kAspectRatio 0.4

@interface A8CycleScrollLayout ()
@property (nonatomic, assign) CGFloat itemWidth; /**< Item 的宽度 */
@property (nonatomic, assign) CGFloat itemHeight; /**< Item 的高度 */
@property (nonatomic, assign) CGFloat maxWidth; /**< 缩放最大宽度 */
@property (nonatomic, assign) CGFloat maxHeight; /**< 缩放最大高度 */
@property (nonatomic, assign) CGFloat pageWidth; /**< CollectionView 滚动一屏的宽度 */
@end

@implementation A8CycleScrollLayout
- (instancetype)init{
    self = [super init];
    if (self) {
        self.minimumLineSpacing  = kSpacing;
        self.maxWidth = [[UIScreen mainScreen] bounds].size.width - 4*kMargin;
        self.maxHeight = self.maxWidth * kAspectRatio;
        self.itemWidth = [[UIScreen mainScreen] bounds].size.width - 2*kMargin - 2*kSpacing;
        self.itemHeight = self.itemWidth * kAspectRatio;
        CGFloat inset = kMargin + kSpacing;
        self.sectionInset = UIEdgeInsetsMake(0, inset, kMargin, inset);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(self.itemWidth, self.itemHeight);
        self.pageWidth = self.itemWidth + inset - kMargin;
    }
    return self;
}

-(NSNumber *)getPageWidth{
    return [NSNumber numberWithFloat:self.pageWidth];
}
/**
 初始化
 */
- (void)prepareLayout {
    [super prepareLayout];
}


/**
 设置每次都可以刷新界面
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    // 计算屏幕的中心X位置
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    // 计算可视范围
    CGRect seeRect;
    seeRect.origin = self.collectionView.contentOffset;
    seeRect.size = self.collectionView.bounds.size;
    for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
        // 如果当前屏幕没有显示则不计算
        if (!CGRectIntersectsRect(seeRect, attributes.frame)) continue;
        // 获取到Item的中心X
        CGFloat itemCenterX = attributes.center.x;
        // 计算宽度缩放比例
        CGFloat widthScale = (1 - ABS(centerX - itemCenterX) / self.collectionView.bounds.size.width * 0.5) * self.maxWidth / self.itemWidth;
        widthScale = MAX(widthScale, 1.0f);
        // 设置Item
        attributes.transform3D = CATransform3DMakeScale(widthScale, widthScale, 1.0f);
    }
    
    return attributesArray;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGRect contentFrame;
    contentFrame.size = self.collectionView.frame.size;
    contentFrame.origin = proposedContentOffset;
    NSArray *array = [self layoutAttributesForElementsInRect:contentFrame];
    CGFloat minCenterX = CGFLOAT_MAX;
    CGFloat collectionViewCenterX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    NSIndexPath *minIndex = nil;
    UICollectionViewLayoutAttributes *minAttr = nil;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if(ABS(attrs.center.x - collectionViewCenterX) < ABS(minCenterX)){
            minCenterX = collectionViewCenterX - attrs.center.x;
            minIndex = attrs.indexPath;
            minAttr = attrs;
        }
    }
    proposedContentOffset.x -= minCenterX;
    return proposedContentOffset;
}

@end
