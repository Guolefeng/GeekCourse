//
//  Glf_CourseViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CourseViewController.h"

@interface Glf_CourseViewController ()

@end

@implementation Glf_CourseViewController

- (void)viewWillAppear:(BOOL)animated {
    // 导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self creatLeftBarButtonItem];
    [self creatRightBarButtonItem];
    [self creatSearchFrameAndScan];
    
}
// 课程分类
- (void)creatLeftBarButtonItem {
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sort"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}
// 历史记录
- (void)creatRightBarButtonItem {
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"history"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
// 搜索框 扫一扫
- (void)creatSearchFrameAndScan {
    // 搜索
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, self.view.frame.size.width - 120, 30);
    searchButton.backgroundColor = [UIColor grayColor];
    searchButton.layer.cornerRadius = 10;
    [searchButton setTitle:@"🔍 搜索相关课程" forState:UIControlStateNormal];
    // 设置 seatchButton 文字对齐方式
    searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // 这行代码可以让按钮的内容距离左边10个像素.
    searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = searchButton;
    
    // 扫一扫
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanButton setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    [searchButton addSubview:scanButton];
    [searchButton addTarget:self action:@selector(scanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.top.equalTo(searchButton).offset(0);
        make.right.equalTo(searchButton).offset(-5);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    
}

- (void)leftBarButtonItemAction:(UIBarButtonItem *)leftBarButton {
    NSLog(@"课程分类");
}

- (void)rightBarButtonItemAction:(UIBarButtonItem *)rightBarButton {
    NSLog(@"历史记录");
}

- (void)searchButtonAction:(UIButton *)button {
    NSLog(@"搜索");
}

- (void)scanButtonAction:(UIButton *)button {
    NSLog(@"扫描");
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
