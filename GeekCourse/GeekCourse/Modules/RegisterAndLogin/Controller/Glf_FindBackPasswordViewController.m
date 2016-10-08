//
//  Glf_FindBackPasswordViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/7.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_FindBackPasswordViewController.h"
#import "UIButton+Block.h"
#import "Glf_FindBackPasswordNextViewController.h"

@interface Glf_FindBackPasswordViewController ()

@property (nonatomic, retain) UITextField *findBackPasswordTF;

@end

@implementation Glf_FindBackPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找回密码";
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    
    [self creatFindBackPasswordTextField];
    [self creatButton];
}

- (void)creatFindBackPasswordTextField {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(50);
        make.height.equalTo(@60);
    }];
    
    self.findBackPasswordTF = [[UITextField alloc] init];
    _findBackPasswordTF.placeholder = @"请输入您的手机号/邮箱";
    _findBackPasswordTF.secureTextEntry = YES;
    _findBackPasswordTF.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:_findBackPasswordTF];
    [_findBackPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(50);
        make.right.equalTo(view).offset(-50);
        make.centerY.equalTo(view.mas_centerY).offset(0);
        make.height.equalTo(@50);
    }];
    
}

- (void)creatButton {
    
    UIButton *nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextStepButton.backgroundColor = [UIColor redColor];
    [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextStepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextStepButton.layer.cornerRadius = 10;
    [self.view addSubview:nextStepButton];
    [nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(_findBackPasswordTF.mas_bottom).offset(50);
        make.height.equalTo(@50);
    }];
    [nextStepButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        Glf_FindBackPasswordNextViewController *findVC = [[Glf_FindBackPasswordNextViewController alloc] init];
        [self.navigationController pushViewController:findVC animated:YES];
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
