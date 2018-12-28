//
//  SecondViewController.m
//  WJRouter
//
//  Created by Minsol on 2018/12/28.
//  Copyright © 2018 A8. All rights reserved.
//

#import "SecondViewController.h"
#import "WJUrlRouterManager.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    WJUrlRequest *request = [WJUrlRequest requestWithUrlString:@"WJRouter://push/ViewController" withParameters:nil];
    [[WJUrlRouterManager sharedManager] openURLWithRequest:request completionHandler:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
