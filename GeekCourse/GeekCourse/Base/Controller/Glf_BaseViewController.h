//
//  Glf_BaseViewController.h
//  GeekCourse
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <SDCycleScrollView.h>
#import <MJRefresh.h>

@interface Glf_BaseViewController : UIViewController

- (void)postWithURL:(NSString *)URL body:(NSString *)body block:(void (^) (id result))block;
- (void)creatScrollViewWithImageNameArray:(NSMutableArray *)imageArray frame:(CGRect)frame view:(UIView *)view;
@end
