//
//  A8CycleScrollCell.h
//  A8CycleScrollView
//
//  Created by Minsol on 2018/11/26.
//  Copyright © 2018 A8. All rights reserved.
//



#import <UIKit/UIKit.h>
@interface A8CycleScrollCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView; /**< 图片 */
@property (nonatomic, strong) UIImageView *newsTitleBackgroundImageView; /**< 标题背景图片 */
@property (nonatomic, strong) UILabel *titleLabel; /**< 标题 */
@end
