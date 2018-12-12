//
//  ViewController.m
//  demo
//
//  Created by Minsol on 2018/10/18.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CornerRadius.h"
#import "UIImageView+FastImage.h"
#import "UIImageView+CornerRadius.h"
#import "NSDictionary+AddParams.h"

#define kHeight 40


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *imageArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    /// 方式一
    NSDictionary *params = [@{@"key":@"value"} addParam:^(DictionaryParamMaker *make) {
        make.addParam(@"key1",@"value1").addParam(@"key2",@"value2");
    }];
    NSLog(@"%@",params);

    /// 方式二
    NSDictionary *params2 = [NSMutableDictionary dictionaryWithDictionary:@{@"key":@"value"}].addParam(@"key1",@"value1").addParam(@"key2",@"value2");
    NSLog(@"%@",params2);

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 500;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSInteger total = 4;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        for (int i=1; i<=total; i++) {
            CGRect frame = CGRectMake(kHeight * (i-1), 2, kHeight, kHeight);
//            UIView *view = [[UIView alloc] initWithFrame:frame];
//            view.backgroundColor = [UIColor redColor];
////            view.layer.backgroundColor = [UIColor redColor].CGColor;
//            [view wj_cornerRadius:30 rectCornerType:UIRectCornerTopRight];
//            [view wj_attachBorderWidth:3 borderColor:[UIColor blueColor]];
//            [cell.contentView addSubview:view];
            
            UIImageView *imageView  = [[UIImageView alloc] initWithFrame:frame];
            imageView.tag = i;
            [imageView wj_cornerRadius:30 rectCornerType:UIRectCornerTopRight];
//            [imageView zy_cornerRadiusAdvance:20 rectCornerType:UIRectCornerTopRight];
            [cell.contentView addSubview:imageView];

//            UIButton * view = [[UIButton alloc]initWithFrame:frame];
//            [view setImage:[UIImage imageNamed:@"03"] forState:UIControlStateNormal];
//            [view wj_cornerRadius:30 rectCornerType:UIRectCornerTopRight];
//            [cell.contentView addSubview:view];
            
//            UILabel *label = [[UILabel alloc]initWithFrame:frame];
//            label.text = @"label";
//            label.backgroundColor = [UIColor redColor];
////            label.layer.backgroundColor = [UIColor blueColor].CGColor;
//            [label wj_cornerRadius:30 rectCornerType:UIRectCornerTopRight];
//            [cell.contentView addSubview:label];
            
            
//            UILabel *label = [[UILabel alloc] initWithFrame:frame];
//            // 重点在此！！设置视图的图层背景色，千万不要直接设置 label.backgroundColor
//            label.layer.backgroundColor = [UIColor grayColor].CGColor;
//            label.layer.cornerRadius = 10;
//            [cell.contentView  addSubview:label];
        }
        
    }
    for (int i=1; i<=total; i++) {
        UIImageView *imageView = [cell viewWithTag:i];
//        NSURL *url = [NSURL URLWithString:[self urlStr:indexPath.row]];
////        [imageView wj_setFastImageWithImagePath:url placeholderImage:nil];
        [imageView wj_setFastImageWithImagePath:@"03" placeholderImage:nil];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kHeight+4;
}
- (NSString *)urlStr:(NSInteger)row {
    NSInteger count = self.imageArr.count;
    NSInteger index = arc4random() % count;
    return [self.imageArr objectAtIndex:index];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)imageArr {
    if (!_imageArr) {
        _imageArr = @[@"http://pic.meizitu.com/wp-content/uploads/2015a/11/11/01.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/11/02.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/11/03.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/11/04.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/11/05.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/11/06.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/11/07.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/11/08.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/11/09.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/11/10.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/12/01.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/12/02.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/12/03.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/12/04.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/12/05.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/12/06.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/12/07.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/13/01.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/13/02.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/13/03.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/13/04.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/13/05.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/13/06.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/13/07.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/14/01.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/14/02.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/14/03.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/14/04.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/14/05.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/14/06.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/15/01.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/15/02.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/15/03.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/15/04.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/15/05.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/15/06.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/15/07.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/15/08.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/16/01.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/16/02.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/16/03.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/16/04.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/16/05.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/16/06.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/16/07.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/16/08.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/16/09.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/17/01.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/17/02.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/17/03.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/17/04.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/17/05.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/17/06.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/17/07.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/17/08.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/18/01.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/18/02.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/18/03.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/18/04.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/18/05.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/18/06.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/18/07.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/18/08.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/19/01.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/19/02.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/19/03.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/19/04.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/19/05.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/19/06.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/19/07.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/19/08.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/19/09.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/20/01.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/20/02.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/20/03.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/20/04.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/20/05.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/20/06.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/20/07.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/20/08.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/20/09.jpg",
                      @"http://pic.meizitu.com/wp-content/uploads/2015a/11/20/10.jpg"];
    }
    return _imageArr;
}







-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
