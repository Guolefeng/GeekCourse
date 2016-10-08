//
//  Glf_FindBackPasswordFinalStepViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/7.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_FindBackPasswordFinalStepViewController.h"
#import "UIButton+Block.h"

@interface Glf_FindBackPasswordFinalStepViewController ()
@property (nonatomic, retain) UITextField *setPasswordTF;
@end

@implementation Glf_FindBackPasswordFinalStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    
    [self creatSetPasswordTextField];
    [self creatButton];
}

- (void)creatSetPasswordTextField {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(50);
        make.height.equalTo(@60);
    }];
    
    self.setPasswordTF = [[UITextField alloc] init];
    _setPasswordTF.placeholder = @"请设置您的登录密码";
    _setPasswordTF.secureTextEntry = YES;
    _setPasswordTF.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:_setPasswordTF];
    [_setPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(50);
        make.right.equalTo(view.mas_centerX).offset(0);
        make.centerY.equalTo(view.mas_centerY).offset(0);
        make.height.equalTo(@50);
    }];
    
}

- (void)creatButton {
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.backgroundColor = [UIColor redColor];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishButton.layer.cornerRadius = 10;
    [self.view addSubview:finishButton];
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(_setPasswordTF.mas_bottom).offset(50);
        make.height.equalTo(@50);
    }];
    [finishButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        NSLog(@"完成");
    }];
    
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
