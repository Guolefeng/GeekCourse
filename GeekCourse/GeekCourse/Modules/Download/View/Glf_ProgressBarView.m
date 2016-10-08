//
//  Glf_ProgressBarView.m
//  GeekCourse
//
//  Created by dllo on 16/10/4.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ProgressBarView.h"

@interface Glf_ProgressBarView ()

@property (nonatomic, retain) UIView *view;
@property (nonatomic, retain) UIView *changingView;
@property (nonatomic, retain) NSTimer *time;

@end

@implementation Glf_ProgressBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.view = [[UIView alloc] init];
        _view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        _view.layer.cornerRadius = 5;
        _view.layer.masksToBounds = YES;
        [self addSubview:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.right.equalTo(self).offset(-30);
            make.top.equalTo(self).offset(100);
            make.height.equalTo(@10);
        }];
        
        self.changingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
        _changingView.backgroundColor = [UIColor colorWithRed:0.20 green:0.71 blue:0.98 alpha:1.0];
        _changingView.layer.cornerRadius = 5;
        _changingView.layer.masksToBounds = YES;
        [self.view addSubview:_changingView];
        
        self.time = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(changeAction) userInfo:nil repeats:YES];
       // [[NSRunLoop mainRunLoop] addTimer:self.time forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)changeAction {
    CGRect changeFrame = self.changingView.frame;
    changeFrame.size.width += 0.25;
    self.changingView.frame = changeFrame;
    if (self.changingView.frame.size.width == self.usedSpace) {
        // 清除 定时器
        [self.time invalidate];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
