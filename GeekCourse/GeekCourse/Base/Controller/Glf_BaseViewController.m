//
//  Glf_BaseViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseViewController.h"
#import "Glf_BaseView.h"
#import "UIBarButtonItem+SetImage_Click.h"

@interface Glf_BaseViewController ()

@end

@implementation Glf_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - POST 请求
- (void)postWithURL:(NSString *)URL body:(NSString *)body block:(void (^)(id result))block {
    
    NSURL *url = [NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    [request setValue:@"mukewang/4.3.2 (iPhone; iOS 7.1.2; Scale/2.00) Paros/3.2.13" forHTTPHeaderField:@"User-Agent"];
    
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!error) {
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                // 传值
                block(result);
            }
            
        });
        
    }];
    
    [dataTask resume];
    
}

#pragma mark - GET 请求
- (void)getWithURL:(NSString *)URL block:(void (^)(id))block {
    NSURL *url = [NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!error) {
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                // 传值
                block(result);
            }
            
        });
        
    }];
    
    [dataTask resume];
    
}

#pragma mark - 轮播图
- (void)creatScrollViewWithImageNameArray:(NSMutableArray *)imageArray frame:(CGRect)frame view:(UIView *)view {
    
    Glf_BaseView *carouselView = [[Glf_BaseView alloc] initWithFrame:frame];
    carouselView.imageArray = imageArray;
    [view addSubview:carouselView];
    
}

#pragma mark - 自定义 leftBarButtonItem
- (void)setLeftBarButtonItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem getBarButtonItemWithImage:[UIImage imageNamed:@"back-1"] target:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - 状态指示器
- (void)doSomething {
    sleep(1);
}
- (void)doSomethingWithProgress {
    float progress = 0.0f;
    while (progress < 1.0) {
        progress += 0.01;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD HUDForView:self.view].progress = progress;
        });
        usleep(50000);
    }
}
- (void)beLoadingMode {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"加载中...";
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomething];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    });
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
