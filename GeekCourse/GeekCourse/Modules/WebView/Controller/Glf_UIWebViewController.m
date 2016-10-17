//
//  Glf_UIWebViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/8.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_UIWebViewController.h"

@interface Glf_UIWebViewController ()
<
UIWebViewDelegate
>

{
    UIWebView *webView;
}

@end

@implementation Glf_UIWebViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [super setLeftBarButtonItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - 64)];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [self.view addSubview:webView];
    [webView loadRequest:request];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    
}


@end
