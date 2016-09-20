//
//  Glf_BaseViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseViewController.h"

@implementation Glf_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
