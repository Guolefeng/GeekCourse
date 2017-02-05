//
//  Glf_BaseViewController.h
//  GeekCourse
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Glf_BaseViewController : UIViewController

- (void)postWithURL:(NSString *)URL body:(NSString *)body block:(void (^) (id result))block;
- (void)getWithURL:(NSString *)URL block:(void (^)(id result))block;
- (void)creatScrollViewWithImageNameArray:(NSMutableArray *)imageArray frame:(CGRect)frame view:(UIView *)view;
- (void)setLeftBarButtonItem;
- (void)beLoadingMode;

@end
