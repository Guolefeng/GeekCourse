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
@interface Glf_BaseViewController : UIViewController

- (void)postWithURL:(NSString *)URL body:(NSString *)body block:(void (^) (id result))block;

@end
