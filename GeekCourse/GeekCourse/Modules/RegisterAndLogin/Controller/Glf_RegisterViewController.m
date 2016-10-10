//
//  Glf_RegisterViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/6.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_RegisterViewController.h"
#import "UIButton+Block.h"
#import "Glf_PhoneRegisterViewController.h"
#import "Glf_MailBoxRegisterViewController.h"
#import "Glf_LoginViewController.h"

@interface Glf_RegisterViewController ()

@property (nonatomic, retain) UIView *littleView;
@property (nonatomic, retain) UITextField *phoneTextField;

@end

@implementation Glf_RegisterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1.0;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"手机注册";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
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
    
    [self creatRegistrationPeocess];
    [self creatPhoneNumberTextField];
    [self creatButton];
}

- (void)creatRegistrationPeocess {
    self.littleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 100)];
    _littleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_littleView];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    [_littleView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_littleView).offset(50);
        make.right.equalTo(_littleView).offset(-50);
        make.centerY.equalTo(_littleView.mas_centerY).offset(-15);
        make.height.equalTo(@5);
    }];
    
    UILabel *firstLabel = [[UILabel alloc] init];
    firstLabel.backgroundColor = [UIColor colorWithRed:0.02 green:0.80 blue:0.54 alpha:1.0];
    firstLabel.text = @"1";
    firstLabel.font = [UIFont systemFontOfSize:20];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.textColor = [UIColor whiteColor];
    [lineView addSubview:firstLabel];
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView).offset(0);
        make.centerY.equalTo(lineView.mas_centerY).offset(0);
        make.width.height.equalTo(@40);
    }];
    firstLabel.layer.cornerRadius = 20;
    firstLabel.clipsToBounds = YES;
    
    UILabel *firstNameLabel = [[UILabel alloc] init];
    firstNameLabel.text = @"输入手机号";
    firstNameLabel.textAlignment = NSTextAlignmentCenter;
    firstNameLabel.textColor = [UIColor colorWithRed:0.02 green:0.80 blue:0.54 alpha:1.0];
    [_littleView addSubview:firstNameLabel];
    [firstNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(firstLabel.mas_centerX).offset(0);
        make.top.equalTo(firstLabel.mas_bottom).offset(5);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    UILabel *secondLabel = [[UILabel alloc] init];
    secondLabel.backgroundColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0];
    secondLabel.text = @"2";
    secondLabel.font = [UIFont systemFontOfSize:20];
    secondLabel.textAlignment = NSTextAlignmentCenter;
    secondLabel.textColor = [UIColor whiteColor];
    [lineView addSubview:secondLabel];
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lineView.mas_centerX).offset(0);
        make.centerY.equalTo(lineView.mas_centerY).offset(0);
        make.width.height.equalTo(@40);
    }];
    secondLabel.layer.cornerRadius = 20;
    secondLabel.clipsToBounds = YES;
    
    UILabel *secondNameLabel = [[UILabel alloc] init];
    secondNameLabel.text = @"输入验证码";
    secondNameLabel.textAlignment = NSTextAlignmentCenter;
    secondNameLabel.textColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0];
    [_littleView addSubview:secondNameLabel];
    [secondNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(secondLabel.mas_centerX).offset(0);
        make.top.equalTo(secondLabel.mas_bottom).offset(5);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    UILabel *thirdLabel = [[UILabel alloc] init];
    thirdLabel.backgroundColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0];
    thirdLabel.text = @"3";
    thirdLabel.font = [UIFont systemFontOfSize:20];
    thirdLabel.textAlignment = NSTextAlignmentCenter;
    thirdLabel.textColor = [UIColor whiteColor];
    [lineView addSubview:thirdLabel];
    [thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lineView).offset(0);
        make.centerY.equalTo(lineView.mas_centerY).offset(0);
        make.width.height.equalTo(@40);
    }];
    thirdLabel.layer.cornerRadius = 20;
    thirdLabel.clipsToBounds = YES;
    
    UILabel *thirdNameLabel = [[UILabel alloc] init];
    thirdNameLabel.text = @"设置密码";
    thirdNameLabel.textAlignment = NSTextAlignmentCenter;
    thirdNameLabel.textColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0];
    [_littleView addSubview:thirdNameLabel];
    [thirdNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(thirdLabel.mas_centerX).offset(0);
        make.top.equalTo(thirdLabel.mas_bottom).offset(5);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
}

- (void)creatPhoneNumberTextField {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(_littleView.mas_bottom).offset(30);
        make.height.equalTo(@60);
    }];
    
    self.phoneTextField = [[UITextField alloc] init];
    _phoneTextField.placeholder = @"请输入手机号码";
    _phoneTextField.backgroundColor = [UIColor whiteColor];
    _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    
    //_phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(50);
        make.right.equalTo(view).offset(-50);
        make.centerY.equalTo(view.mas_centerY).offset(0);
        make.height.equalTo(@50);
    }];
}

- (void)creatButton {
    UIButton *getVerifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getVerifyCodeButton.backgroundColor = [UIColor redColor];
    [getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getVerifyCodeButton.layer.cornerRadius = 10;
    [self.view addSubview:getVerifyCodeButton];
    [getVerifyCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(_phoneTextField.mas_bottom).offset(50);
        make.height.equalTo(@50);
    }];
    [getVerifyCodeButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        Glf_PhoneRegisterViewController *phoneRegisterVC = [[Glf_PhoneRegisterViewController alloc] init];
        [self.navigationController pushViewController:phoneRegisterVC animated:YES];
    }];
    
    UIButton *mailBoxRegisterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mailBoxRegisterButton setTitle:@"邮箱注册" forState:UIControlStateNormal];
   [mailBoxRegisterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:mailBoxRegisterButton];
    [mailBoxRegisterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(getVerifyCodeButton.mas_bottom).offset(30);
        make.height.equalTo(@50);
    }];
    [mailBoxRegisterButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        Glf_MailBoxRegisterViewController *mailBoxRegisterVC = [[Glf_MailBoxRegisterViewController alloc] init];
        [self.navigationController pushViewController:mailBoxRegisterVC animated:YES];
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
