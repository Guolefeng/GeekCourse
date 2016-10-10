//
//  Glf_LoginViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/6.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_LoginViewController.h"
#import "Glf_RegisterViewController.h"
#import "UIButton+Block.h"
#import "Glf_FindBackPasswordViewController.h"

@interface Glf_LoginViewController ()

@property (nonatomic, retain) UITextField *mailORPhoneTF;
@property (nonatomic, retain) UITextField *passwordTF;
@property (nonatomic, retain) UIButton *foundBackPassword;

@end

@implementation Glf_LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1.0;
    self.title = @"登录";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
- (void)rightBarButtonItemAction {
    Glf_RegisterViewController *registerVC = [[Glf_RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    
    [self creatMailBoxOrPhoneNumberTextField];
    [self creatPasswordTextField];
    [self creatButton];
    [self creatOtherMethodsForLogin];
}


- (void)creatMailBoxOrPhoneNumberTextField {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(30);
        make.height.equalTo(@60);
    }];
    
    self.mailORPhoneTF = [[UITextField alloc] init];
    _mailORPhoneTF.placeholder = @"邮箱/手机号";
    _mailORPhoneTF.backgroundColor = [UIColor whiteColor];
    _mailORPhoneTF.clearButtonMode = UITextFieldViewModeAlways;
    //_phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [view addSubview:_mailORPhoneTF];
    [_mailORPhoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(self.mailORPhoneTF.mas_bottom).offset(10);
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
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = [UIColor redColor];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.layer.cornerRadius = 10;
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(_passwordTF.mas_bottom).offset(50);
        make.height.equalTo(@50);
    }];
    [loginButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        NSLog(@"登录");
    }];
    
    self.foundBackPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [_foundBackPassword setTitle:@"找回密码" forState:UIControlStateNormal];
    [_foundBackPassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_foundBackPassword];
    
    [_foundBackPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(loginButton.mas_bottom).offset(30);
        make.height.equalTo(@50);
    }];
    [_foundBackPassword handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        Glf_FindBackPasswordViewController *findBackVC = [[Glf_FindBackPasswordViewController alloc] init];
        [self.navigationController pushViewController:findBackVC animated:YES];
    }];
}

- (void)creatOtherMethodsForLogin {
    UIView *leftLineView = [[UIView alloc] init];
    leftLineView.backgroundColor = [UIColor grayColor];
    leftLineView.alpha = 0.5;
    [self.view addSubview:leftLineView];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(_foundBackPassword.mas_bottom).offset(50);
        make.right.equalTo(self.view.mas_centerX).offset(-80);
        make.height.equalTo(@1);
    }];
    
    UIView *rightLineView = [[UIView alloc] init];
    rightLineView.backgroundColor = [UIColor grayColor];
    rightLineView.alpha = 0.5;
    [self.view addSubview:rightLineView];
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(_foundBackPassword.mas_bottom).offset(50);
        make.left.equalTo(self.view.mas_centerX).offset(80);
        make.height.equalTo(@1);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"其他方式登录";
    label.textColor = [UIColor grayColor];
    label.alpha = 0.5;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLineView.mas_right).offset(0);
        make.right.equalTo(rightLineView.mas_left).offset(0);
        make.centerY.equalTo(leftLineView.mas_centerY).offset(0);
        make.height.equalTo(@30);
    }];
    
    UIButton *sinaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sinaButton setBackgroundImage:[UIImage imageNamed:@"sina"] forState:UIControlStateNormal];
    [self.view addSubview:sinaButton];
    [sinaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(label.mas_centerX).offset(0);
        make.top.equalTo(label.mas_bottom).offset(50);
        make.width.height.equalTo(@100);
    }];
    sinaButton.layer.cornerRadius = 50;
    sinaButton.clipsToBounds = YES;
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
