//
//  Glf_HandRecordCategoryViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_HandRecordCategoryViewController.h"
#import "UIButton+Block.h"

@implementation Glf_HandRecordCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    [self creatNavBar];
    
    [self getCategoryData];
    
}
#pragma mark - 创建导航栏
- (void)creatNavBar {
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 64)];
    nameLabel.backgroundColor = [UIColor blackColor];
    nameLabel.text = @"选择分类";
    nameLabel.font = [UIFont systemFontOfSize:20];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:nameLabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 18, 30, 30);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.view addSubview:backButton];
}

#pragma mark - 获取分类数据
- (void)getCategoryData {
    [super postWithURL:@"http://www.imooc.com/api3/labletype" body:@"token=b09b24a0e9720b63b387667ad915eac3&uid=3859703" block:^(id result) {
    
    }];
}

@end
