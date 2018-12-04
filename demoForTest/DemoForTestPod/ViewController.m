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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - properties




@end
