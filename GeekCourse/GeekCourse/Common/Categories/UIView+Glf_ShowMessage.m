//
//  UIView+Glf_ShowMessage.m
//  GeekCourse
//
//  Created by dllo on 16/10/15.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "UIView+Glf_ShowMessage.h"
#import "UILabel+Glf_SizeToFit_W_H.h"

@implementation UIView (Glf_ShowMessage)

+ (void)showMessage:(NSString *)message {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor grayColor];
    view.frame = CGRectMake(1, 1, 1, 1);
    view.alpha = 1.0;
    view.layer.cornerRadius = 5;
    view.clipsToBounds = YES;
    [window addSubview:view];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = message;
    CGFloat width = [UILabel getWidthWithTitle:message font:label.font];
    label.frame = CGRectMake(10, 5, width, 18);
    [view addSubview:label];
    
    view.frame = CGRectMake((WIDTH_SCREEN - width - 20) / 2, HEIGHT_SCREEN / 2 + 100, width + 20, 25);
    [UIView animateWithDuration:1.5 animations:^{
        
        view.frame = CGRectMake((WIDTH_SCREEN - width - 20) / 2, HEIGHT_SCREEN / 2 + 70, width + 20, 25);
        
    } completion:^(BOOL finished) {
        
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [view removeFromSuperview];
        });
        
    }];
}


@end
