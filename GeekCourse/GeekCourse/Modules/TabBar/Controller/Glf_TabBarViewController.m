//
//  Glf_TabBarViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_TabBarViewController.h"

#import "Glf_CourseViewController.h"
#import "Glf_DownloadViewController.h"
#import "Glf_DiscoverViewController.h"
#import "Glf_MineViewController.h"


@interface Glf_TabBarViewController ()
<
UITabBarControllerDelegate
>
@end

@implementation Glf_TabBarViewController

- (void)dealloc {
    // 代理的置空操作
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    
    // 课程
    Glf_CourseViewController *courseVC = [[Glf_CourseViewController alloc] init];
    UINavigationController *courseNC = [[UINavigationController alloc] initWithRootViewController:courseVC];
    
    UIImage *courseImage = [UIImage imageNamed:@"coursep"];
    courseImage = [courseImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedCourseImage = [UIImage imageNamed:@"course"];
    selectedCourseImage = [selectedCourseImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    courseNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"课程" image:courseImage selectedImage:selectedCourseImage];
    
    // 下载
    Glf_DownloadViewController *downloadVC = [[Glf_DownloadViewController alloc] init];
    UINavigationController *downloadNC = [[UINavigationController alloc] initWithRootViewController:downloadVC];
    
    UIImage *downloadImage = [UIImage imageNamed:@"downloadp"];
    downloadImage = [downloadImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedDownloadImage = [UIImage imageNamed:@"download"];
    selectedDownloadImage = [selectedDownloadImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    downloadNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"下载" image:downloadImage selectedImage:selectedDownloadImage];
    
    // 发现
    Glf_DiscoverViewController *discoverVC = [[Glf_DiscoverViewController alloc] init];
    UINavigationController *discoverNC = [[UINavigationController alloc] initWithRootViewController:discoverVC];
    
    UIImage *discoverImage = [UIImage imageNamed:@"discoverp"];
    discoverImage = [discoverImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedDiscoverImage = [UIImage imageNamed:@"discover"];
    selectedDiscoverImage = [selectedDiscoverImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    discoverNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:discoverImage selectedImage:selectedDiscoverImage];
    
    // 我的
    Glf_MineViewController *mineVC = [[Glf_MineViewController alloc] init];
    UINavigationController *mineNC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    UIImage *mineImage = [UIImage imageNamed:@"minep"];
    mineImage = [mineImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedMineImage = [UIImage imageNamed:@"mine"];
    selectedMineImage = [selectedMineImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:mineImage selectedImage:selectedMineImage];
    
    self.viewControllers = @[courseNC, downloadNC, discoverNC, mineNC];
    // 设置代理人
    self.delegate = self;
    self.tabBar.tintColor = [UIColor redColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    //self.tabBar.translucent = NO;
    
    // 添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenTabBarAction:) name:@"WhenPushPage" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTabBarAction:) name:@"BackToTabBarViewController" object:nil];
    
}

- (void)showTabBarAction:(NSNotification *)notification {
    self.tabBar.hidden = NO;
}

- (void)hiddenTabBarAction:(NSNotification *)notification {
    self.tabBar.hidden = YES;
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"seleted %lu", tabBarController.selectedIndex);
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
