//
//  Glf_MailBoxRegisterViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/6.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_MailBoxRegisterViewController.h"
#import "Glf_LoginViewController.h"
#import "UIButton+Block.h"
#import "Glf_RegisterViewController.h"

@interface Glf_MailBoxRegisterViewController ()

@property (nonatomic, retain) UITextField *mailBoxTF;
@property (nonatomic, retain) UITextField *passwordTF;

@end

@implementation Glf_MailBoxRegisterViewController

- (void)viewWillAppear:(BOOL)animated {
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
- (void)rightBarButtonItemAction {
    Glf_LoginViewController *loginVC = [[Glf_LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    
    [self creatMailBoxTextField];
    [self creatPasswordTextField];
    [self creatButton];
}

- (void)creatMailBoxTextField {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(30);
        make.height.equalTo(@60);
    }];
    
    self.mailBoxTF = [[UITextField alloc] init];
    _mailBoxTF.placeholder = @"邮箱";
    _mailBoxTF.backgroundColor = [UIColor whiteColor];
    _mailBoxTF.clearButtonMode = UITextFieldViewModeAlways;
    //_phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [view addSubview:_mailBoxTF];
    [_mailBoxTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(50);
        make.right.equalTo(view).offset(-50);
        make.centerY.equalTo(view.mas_centerY).offset(0);
        make.height.equalTo(@50);
    }];
    
}

- (void)creatPasswordTextField {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.mailBoxTF.mas_bottom).offset(10);
        make.height.equalTo(@60);
    }];
    
    self.passwordTF = [[UITextField alloc] init];
    _passwordTF.placeholder = @"密码";
    _passwordTF.secureTextEntry = YES;
    _passwordTF.backgroundColor = [UIColor whiteColor];
    //_phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [view addSubview:_passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(50);
        make.right.equalTo(view).offset(-50);
        make.centerY.equalTo(view.mas_centerY).offset(0);
        make.height.equalTo(@50);
    }];
    
}

- (void)creatButton {
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.backgroundColor = [UIColor redColor];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.layer.cornerRadius = 10;
    [self.view addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(_passwordTF.mas_bottom).offset(50);
        make.height.equalTo(@50);
    }];
    [submitButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        NSLog(@"提交");
    }];
    
    UIButton *phoneRegisterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneRegisterButton setTitle:@"手机注册" forState:UIControlStateNormal];
    [phoneRegisterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:phoneRegisterButton];
    
    [phoneRegisterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(submitButton.mas_bottom).offset(30);
        make.height.equalTo(@50);
    }];
    [phoneRegisterButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        Glf_RegisterViewController *registerVC = [[Glf_RegisterViewController alloc] init];
        [self.navigationController pushViewController:registerVC animated:YES];
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
