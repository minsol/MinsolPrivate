//
//  AppRoutesViewController.m
//  demo
//
//  Created by Minsol on 2018/12/21.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "AppRoutesViewController.h"
#import "AppDelegate+RegisterRoute.h"
@interface AppRoutesViewController ()

@end

@implementation AppRoutesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate openURLString:@"RouteDemo://push/CornerRadiusViewController"];
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
