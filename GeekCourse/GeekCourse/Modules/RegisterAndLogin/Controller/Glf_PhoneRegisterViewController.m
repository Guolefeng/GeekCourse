//
//  Glf_PhoneRegisterViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/6.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_PhoneRegisterViewController.h"
#import "Glf_LoginViewController.h"
#import "UIButton+Block.h"
#import "Glf_NextStepViewController.h"

@interface Glf_PhoneRegisterViewController ()

@property (nonatomic, retain) UIView *littleView;
@property (nonatomic, retain) UITextField *verifyCodeTextField;

@end

@implementation Glf_PhoneRegisterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
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
    [self creatVerifyCodeTextField];
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
    secondLabel.backgroundColor = [UIColor colorWithRed:0.02 green:0.80 blue:0.54 alpha:1.0];
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
    secondNameLabel.textColor = [UIColor colorWithRed:0.02 green:0.80 blue:0.54 alpha:1.0];
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

- (void)creatVerifyCodeTextField {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(_littleView.mas_bottom).offset(30);
        make.height.equalTo(@60);
    }];
    
    self.verifyCodeTextField = [[UITextField alloc] init];
    _verifyCodeTextField.placeholder = @"请填写验证码";
    _verifyCodeTextField.backgroundColor = [UIColor whiteColor];
    _verifyCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
    //_phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [view addSubview:_verifyCodeTextField];
    [_verifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(_verifyCodeTextField.mas_bottom).offset(50);
        make.height.equalTo(@50);
    }];
    [nextStepButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        Glf_NextStepViewController *nextStepVC = [[Glf_NextStepViewController alloc] init];
        [self.navigationController pushViewController:nextStepVC animated:YES];
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
