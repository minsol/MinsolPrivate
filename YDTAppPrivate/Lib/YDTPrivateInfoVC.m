//
//  YDTPrivateInfoVC.m
//  A8iOS_Private_Lib
//
//  Created by 白云 on 2018/9/30.
//  Copyright © 2018年 New Sense Networks Technology Co., Ltd. All rights reserved.
//

#import "YDTPrivateInfoVC.h"
#import <Masonry.h>

/// 获取App名
#define PRIVATEINFO_APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

NSString *const kPrivateInfoKey = @"showPrivateInfo";

@interface YDTPrivateInfoVC () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *contextView;
@property (nonatomic, strong) UIButton *agreeButton;
@property (nonatomic, strong) UIButton *refuseButton;

@end

@implementation YDTPrivateInfoVC

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    _titleLabel.text = [NSString stringWithFormat:@"%@隐私政策",PRIVATEINFO_APP_NAME];
    _titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(52.0);
    }];
    
    _contextView = [[UITextView alloc] initWithFrame:CGRectZero];
    _contextView.textColor = [UIColor colorWithWhite:32/255.0 alpha:1.0];
    _contextView.font = [UIFont systemFontOfSize:14.0];
    _contextView.editable = NO;
    _contextView.delegate = self;
    _contextView.attributedText = [self configContextString];
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineSpacing = 8.0;
    _contextView.linkTextAttributes = @{
                                        NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0],
                                        NSForegroundColorAttributeName:[UIColor colorWithRed:1.0 green:190/255.0 blue:0.0 alpha:1.0],
                                        NSParagraphStyleAttributeName:paragraph,
                                        NSUnderlineColorAttributeName: [UIColor clearColor],
                                        NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)
                                        };
    [self.view addSubview:_contextView];
    [_contextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(24.0);
        make.left.equalTo(self.view).offset(30.0);
        make.right.equalTo(self.view).offset(-30.0);
        make.bottom.equalTo(self.view).offset(-96.0);
    }];
    
    _agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_agreeButton setTitle:@"同意" forState:UIControlStateNormal];
    [_agreeButton setTitleColor:[UIColor colorWithWhite:32/255.0 alpha:1.0] forState:UIControlStateNormal];
    _agreeButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_agreeButton setBackgroundColor:[UIColor colorWithRed:1.0 green:192/255.0 blue:0.0 alpha:1.0]];
    _agreeButton.layer.cornerRadius = 2.0;
    [_agreeButton addTarget:self action:@selector(agreeButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_agreeButton];
    [_agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(144.0);
        make.height.mas_equalTo(42.0);
        make.centerX.equalTo(self.view).multipliedBy(1.5);
        make.bottom.equalTo(self.view).offset(-22.0);
    }];
    
    _refuseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_refuseButton setTitle:@"不同意" forState:UIControlStateNormal];
    [_refuseButton setTitleColor:[UIColor colorWithWhite:32/255.0 alpha:1.0] forState:UIControlStateNormal];
    _refuseButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _refuseButton.layer.cornerRadius = 2.0;
    _refuseButton.layer.borderColor = [UIColor colorWithWhite:151/255.0 alpha:1.0].CGColor;
    _refuseButton.layer.borderWidth = 1.0;
    [_refuseButton addTarget:self action:@selector(refuseButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_refuseButton];
    [_refuseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.equalTo(self.agreeButton);
        make.centerX.equalTo(self.view).multipliedBy(0.5);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark - Private method
- (NSAttributedString *)configContextString {
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineSpacing = 8.0;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:self.contextView.linkTextAttributes];
    [attributes setObject:[UIFont systemFontOfSize:14.0] forKey:NSFontAttributeName];
    [attributes setObject:[UIColor colorWithWhite:32/255.0 alpha:1.0] forKey:NSForegroundColorAttributeName];
    [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSString *protocolName = [NSString stringWithFormat:@"《%@隐私政策》",PRIVATEINFO_APP_NAME];
    NSAttributedString *headerString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"感谢您下载%@！当您开始使用本软件时，我们可能会对您的部分个人信息进行收集，使用和共享。请您仔细阅读%@并确定了解我们对您个人信息的处理规则，包括：\n\n",PRIVATEINFO_APP_NAME,protocolName] attributes:attributes];
    
    [attributes setObject:[UIFont systemFontOfSize:14.0] forKey:NSFontAttributeName];
    
    NSAttributedString *contentString = [[NSAttributedString alloc] initWithString:@"我们如何收集和使用您的个人信息\n我们如何使用Cookie和同类技术\n我们如何共享，转让，公开您的个人信息\n我们如何保护和保留您的个人信息\n您如何管理个人信息\n未成年人信息的保护\n如何联系我们\n\n" attributes:attributes];
    
    NSMutableAttributedString *bottomString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"如您同意%@请点击“同意”开始 使用我们的产品和服务，我们尽力保护您的个人信息安全",protocolName] attributes:attributes];
    [bottomString addAttribute:NSLinkAttributeName value:@"https://h5.a8sport.com/h5/privacy/A8information.html" range:[[bottomString string] rangeOfString:protocolName]];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:headerString];
    [string appendAttributedString:contentString];
    [string appendAttributedString:bottomString];
    
    return string;
}

#pragma makr - Action
- (void)refuseButtonClickAction:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"非常抱歉！您需要仔细阅读并同意我们的隐私政策才可以继续使用我们的产品和服务。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:sureAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)agreeButtonClickAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.completedHandle) {
            weakSelf.completedHandle();
        }
    }];
}

#pragma mark - UITextViewDelegate

#pragma mark - Other
- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

@end

@implementation UIViewController (YDTPrivateInfoVC)

/**
 显示App隐私权页面
 */
- (void)showPrivateInformationViewWithHandle:(YDTPrivateInfoCompletedBlock)handle {
    BOOL showPrivateInfo = [[NSUserDefaults standardUserDefaults] boolForKey:kPrivateInfoKey];
    if (!showPrivateInfo) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kPrivateInfoKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        YDTPrivateInfoVC *privateInfoVC = [YDTPrivateInfoVC new];
        privateInfoVC.completedHandle = handle;
        [self presentViewController:privateInfoVC animated:YES completion:nil];
    }
}

@end
