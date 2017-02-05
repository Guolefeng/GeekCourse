//
//  Glf_GuideViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_GuideViewController.h"
#import "Glf_CourseViewController.h"

#define WIDITH (NSInteger)self.view.bounds.size.width
#define HEIGHT (NSInteger)self.view.bounds.size.height

@interface Glf_GuideViewController ()
<
UIScrollViewDelegate
>

{
    // 创建页码控制器
    UIPageControl *pageControl;
    // 判断是否第一次进入应用
    BOOL flag;
}
@end

@implementation Glf_GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    for (int i = 0; i <= 2; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpeg", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDITH * i, 0, WIDITH, HEIGHT)];
        
        if (2 == i) {
            // 设置用户交互
            imageView.userInteractionEnabled = YES;
            
            // 创建一个 UIButton
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(WIDITH / 3, HEIGHT * 7 / 8, WIDITH / 3, HEIGHT / 16);
            [button setTitle:@"点击进入" forState:UIControlStateNormal];
            
            // 设置 button 圆角
            button.layer.borderWidth = 2;
            button.layer.cornerRadius = 5;
            button.clipsToBounds = YES;
            //  设置 button 边框颜色
            button.layer.borderColor = [UIColor cyanColor].CGColor;
            
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [imageView addSubview:button];
        }
        
        imageView.image = image;
        [scrollView addSubview:imageView];
    }
    // 关闭回弹效果
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    // 隐藏水平滑动条
    scrollView.showsHorizontalScrollIndicator = NO;
    // 偏移量
    scrollView.contentSize = CGSizeMake(WIDITH * 3, HEIGHT);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 设置 pageControl
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDITH / 3, HEIGHT * 15/ 16, WIDITH / 3, HEIGHT / 16)];
    pageControl.numberOfPages = 3;
    pageControl.pageIndicatorTintColor = [UIColor cyanColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:1.000 green:0.385 blue:0.532 alpha:1.0];
    [self.view addSubview:pageControl];
    
}
// scrollView 减速结束后
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
}

- (void)buttonAction:(UIButton *)button {
    
    flag = YES;
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    // 保存用户数据
    [userDef setBool:flag forKey:@"norFirst"];
    [userDef synchronize];
    // 切换视图控制器
   // self.view.window.rootViewController = [[Glf_RegisterAndLoginViewController alloc] init];
    
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
