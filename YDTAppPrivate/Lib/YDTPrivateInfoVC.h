//
//  YDTPrivateInfoVC.h
//  A8iOS_Private_Lib
//
//  Created by 白云 on 2018/9/30.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YDTPrivateInfoCompletedBlock)(void);

@interface YDTPrivateInfoVC : UIViewController

/// 完成回调
@property (nonatomic, copy) YDTPrivateInfoCompletedBlock completedHandle;

@end


@interface UIViewController(YDTPrivateInfoVC)

/**
 显示App隐私权页面
 */
- (void)showPrivateInformationViewWithHandle:(YDTPrivateInfoCompletedBlock)handle;

@end
