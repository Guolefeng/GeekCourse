//
//  Glf_DownloadViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_DownloadViewController.h"
#import "UIButton+Block.h"
#import "Glf_ProgressBarView.h"
#import "Glf_CourseCatagoryViewController.h"

@interface Glf_DownloadViewController ()

@property (nonatomic, retain) UIImageView *backgroundImageView;

@end

@implementation Glf_DownloadViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackToTabBarViewController" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.title = @"下载";
    
    [self creatDescSpaceOfDeviceLabel];
    
    [self creatBackImage];
    [self creatDownloadButton];
    
}

#pragma mark - 创建下载图片
- (void)creatBackImage {
    self.backgroundImageView = [[UIImageView alloc] init];
    _backgroundImageView.image = [UIImage imageNamed:@"backgoroundImage"];
    [self.view addSubview:_backgroundImageView];
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.centerY.equalTo(self.view.mas_centerY).offset(0);
        make.width.height.equalTo(@300);
    }];
}

#pragma mark - 创建下载按钮
- (void)creatDownloadButton {
    UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    downloadButton.backgroundColor = [UIColor whiteColor];
    
    downloadButton.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
    downloadButton.layer.borderWidth = 1;
    downloadButton.layer.cornerRadius = 10;
    
    [downloadButton setTitle:@"去添加下载" forState:UIControlStateNormal];
    [downloadButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [downloadButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        Glf_CourseCatagoryViewController *courseVC = [[Glf_CourseCatagoryViewController alloc] init];
        [self.navigationController pushViewController:courseVC animated:YES];
    }];
    
    [self.view addSubview:downloadButton];
    [downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backgroundImageView.mas_centerX).offset(0);
        make.top.equalTo(_backgroundImageView.mas_bottom).offset(30);
        make.width.equalTo(@200);
        make.height.equalTo(@50);
    }];
}

#pragma mark - 创建设备容量说明 Label
- (void)creatDescSpaceOfDeviceLabel {
    
    UILabel *deviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, WIDTH_SCREEN - 60, 50)];
    
    CGFloat total = [self totalDiskSpace];
    CGFloat free = [self freeDiskSpace];
    CGFloat used = total - free;
    
    deviceLabel.text = [NSString stringWithFormat:@"已占用%.1fG, 剩余%.1fG可用", used, free];
    deviceLabel.textColor = [UIColor grayColor];
    [self.view addSubview:deviceLabel];
    
    Glf_ProgressBarView *progressBar = [[Glf_ProgressBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 50)];
    
   // 换算成屏幕的宽度的比例
    progressBar.usedSpace = (NSInteger)((used / total) * (WIDTH_SCREEN - 60));
    [self.view addSubview:progressBar];
    
}

#pragma mark - 获取当前设备的总容量 (单位 GB)
- (CGFloat)totalDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    NSNumber *volume = [fattributes objectForKey:NSFileSystemSize];
    double totalVolume = [volume doubleValue];
    
    return totalVolume / (1024.0 * 1024.0 * 1024.0);
}

#pragma mark - 获取当前设备的可用容量 (单位 GB)
- (CGFloat)freeDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *volume = [fattributes objectForKey:NSFileSystemFreeSize];
    double freeDiskVolume = [volume doubleValue];
    
    return freeDiskVolume / (1024.0 * 1024.0 * 1024.0);
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
