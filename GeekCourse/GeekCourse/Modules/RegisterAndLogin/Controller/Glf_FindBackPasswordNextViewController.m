//
//  Glf_FindBackPasswordNextViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/7.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_FindBackPasswordNextViewController.h"
#import "UIButton+Block.h"
#import "Glf_FindBackPasswordFinalStepViewController.h"

@interface Glf_FindBackPasswordNextViewController ()
@property (nonatomic, retain) UITextField *phoneVerifyCodeTF;
@end

@implementation Glf_FindBackPasswordNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    
    [self creatPhoneVerifyCodeTextField];
    [self creatButton];
}

- (void)creatPhoneVerifyCodeTextField {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(50);
        make.height.equalTo(@60);
    }];
    
    self.phoneVerifyCodeTF = [[UITextField alloc] init];
    _phoneVerifyCodeTF.placeholder = @"请填写手机验证码";
    _phoneVerifyCodeTF.secureTextEntry = YES;
    _phoneVerifyCodeTF.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:_phoneVerifyCodeTF];
    [_phoneVerifyCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(50);
        make.right.equalTo(view.mas_centerX).offset(0);
        make.centerY.equalTo(view.mas_centerY).offset(0);
        make.height.equalTo(@50);
    }];
    
    UIButton *getVerifyCodeAgainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getVerifyCodeAgainButton.backgroundColor = [UIColor colorWithRed:0.02 green:0.80 blue:0.54 alpha:1.0];
    [getVerifyCodeAgainButton setTitle:@"重新获取" forState:UIControlStateNormal];
    getVerifyCodeAgainButton.layer.cornerRadius = 10;
    [view addSubview:getVerifyCodeAgainButton];
    [getVerifyCodeAgainButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_centerX).offset(50);
        make.right.equalTo(view).offset(-30);
        make.centerY.equalTo(view.mas_centerY).offset(0);
        make.height.equalTo(@40);
    }];
    [getVerifyCodeAgainButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        NSLog(@"重新获取验证码");
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
        make.top.equalTo(_phoneVerifyCodeTF.mas_bottom).offset(50);
        make.height.equalTo(@50);
    }];
    [nextStepButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        Glf_FindBackPasswordFinalStepViewController *findVC = [[Glf_FindBackPasswordFinalStepViewController alloc] init];
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
