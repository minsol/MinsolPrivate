//
// YDTNewsTagView.h
//  A8TV_IPhone
//
//  Created by Minsol on 2018/8/2.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

typedef NS_ENUM(NSUInteger,YDTNewsTagType) {
   YDTNewsTagTypeTopic = 1, /**< 话题 */
   YDTNewsTagTypeHotPost, /**< 热帖 */
   YDTNewsTagTypeActivity, /**< 活动 */
   YDTNewsTagTypeDiscuss, /**< 讨论 */
   YDTNewsTagTypeAdvertising, /**< 广告 */
   YDTNewsTagTypeCustom, /**< 自定义 */
};


/**
 新闻列表标签
 */
@interface YDTNewsTagView : UIView

#pragma mark - Property

#pragma mark - Method
-(void)setTagType:(YDTNewsTagType)tagType;
-(void)setTagType:(YDTNewsTagType)tagType title:(NSString *)title;

@end
