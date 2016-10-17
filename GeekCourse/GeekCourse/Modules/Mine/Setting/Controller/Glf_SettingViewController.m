//
//  Glf_SettingViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_SettingViewController.h"
#import "Glf_NightModeTableViewCell.h"
#import "Glf_ClearCacheTableViewCell.h"

@interface Glf_SettingViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate
>

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation Glf_SettingViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1.0;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
    
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.title = @"设置";
    [super setLeftBarButtonItem];
    
    [self creatTableView];
    [self setNightMode];
    
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor cyanColor];
    _tableView.rowHeight = 40;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[Glf_NightModeTableViewCell class] forCellReuseIdentifier:@"nightModelCell"];
    [_tableView registerClass:[Glf_ClearCacheTableViewCell class] forCellReuseIdentifier:@"clearCacheCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        Glf_NightModeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nightModelCell"];
        return cell;
    }
    if (indexPath.row == 1) {
        Glf_ClearCacheTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clearCacheCell"];
        cell.cacheSizeString = [self getCacheSize];
        return cell;
    }
    else {
        return nil;
    }
    
}

- (void)setNightMode {
    
    [_tableView jxl_setDayMode:^(UIView *view) {
        view.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        view.backgroundColor = [UIColor blackColor];
    }];
    
    [self.navigationController.navigationBar jxl_setDayMode:^(UIView *view) {
        UINavigationBar *bar = (UINavigationBar *)view;
        bar.barTintColor = [UIColor redColor];
        bar.barStyle = UIBarStyleDefault;
        
    } nightMode:^(UIView *view) {
        UINavigationBar *bar = (UINavigationBar *)view;
        bar.barTintColor = [UIColor blackColor];
        bar.barStyle = UIBarStyleBlack;
    }];
}

#pragma mark - 清除缓存提示
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"缓存清除" message:@"确定清楚缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

#pragma mark - UIAlertViewDelegate 方法实现
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
        [fileManager removeItemAtPath:cacheFilePath error:nil];
        
        [_tableView reloadData];
    }
}

#pragma mark - 计算缓存大小
- (NSString *)getCacheSize {
    // 定义变量存储总的缓存大小
    long long sumSize = 0;
    
    // 1. 获取当前图片缓存路径
    NSString *cacheFilePath =  [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    
    // 2. 创建文件管理对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
        // 获取当前缓存路径下的所有自路径
    NSArray *subPaths = [fileManager subpathsOfDirectoryAtPath:cacheFilePath error:nil];
    
        // 遍历所有子文件
    for (NSString *subPath in subPaths) {
            // 1). 拼接完整路径
        NSString *filePath = [cacheFilePath stringByAppendingFormat:@"/%@", subPath];
            // 2). 计算文件的大小
        long long fileSize = [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
        sumSize += fileSize;
    }
    float size_m = sumSize / (1024 * 1024);
    return [NSString stringWithFormat:@"%.2fM", size_m];
}

@end
