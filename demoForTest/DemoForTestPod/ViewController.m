//
//  ViewController.m
//  A8CycleScrollView
//
//  Created by Minsol on 2018/10/16.
//  Copyright © 2018 New Sense Networks Technology Co., Ltd. All rights reserved.
//


#import "ViewController.h"
#import "DatabaseAdaptor.h"
#import "SecurityAdaptor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[SecurityAdaptor encodeBase64String:@"minsol"]);
    NSLog(@"%@",[SecurityAdaptor md5:@"minsold"]);

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"RouteDemo://push/AppRoutesViewController"]];
    if (canOpen) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"RouteDemo://push/AppRoutesViewController"]];
    }
    NSLog(@"canOpen %@",canOpen? @"ture":@"false");
    BOOL open =  [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"RouteDemo://push/AppRoutesViewController"]];
    NSLog(@"open %@",open? @"ture":@"false");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - properties




@end
