//
//  Glf_RegisterAndLoginViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/6.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_RegisterAndLoginViewController.h"
#import "UIButton+Block.h"
#import "Glf_TabBarViewController.h"
#import "Glf_LoginViewController.h"
#import "Glf_RegisterViewController.h"

@interface Glf_RegisterAndLoginViewController ()

@property (nonatomic, retain) UIImageView *backgroudImageView;
@property (nonatomic, retain) UIButton *registerButton;
@property (nonatomic, retain) UIButton *loginButton;
@property (nonatomic, retain) UIButton *directEnterButton;
@end

@implementation Glf_RegisterAndLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.backgroudImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, WIDTH_SCREEN, HEIGHT_SCREEN)];
    _backgroudImageView.image = [UIImage imageNamed:@"registerBackgroudImage"];
    [self.view addSubview:_backgroudImageView];
    
    [self creatRegisterButton];
    [self creatLoginButton];
    [self creatDirectEnterButton];
}

- (void)creatRegisterButton {
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerButton.backgroundColor = [UIColor colorWithRed:0.94 green:0.09 blue:0.09 alpha:1.0];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _registerButton.layer.cornerRadius = 10;
    [self.view addSubview:_registerButton];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(self.view).offset(self.view.frame.size.height * 0.5);
        make.height.equalTo(@50);
    }];
    
    [_registerButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        NSLog(@"注册");
        Glf_RegisterViewController *registerVC = [[Glf_RegisterViewController alloc] init];
        [self.navigationController pushViewController:registerVC animated:YES];
    }];
}

- (void)creatLoginButton {
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _loginButton.layer.cornerRadius = 10;
    _loginButton.layer.borderColor = [UIColor redColor].CGColor;
    _loginButton.layer.borderWidth = 1.f;
    [self.view addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(_registerButton.mas_bottom).offset(30);
        make.height.equalTo(@50);
    }];
    [_loginButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        NSLog(@"登录");
        Glf_LoginViewController *loginVC = [[Glf_LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }];
}

- (void)creatDirectEnterButton {
    self.directEnterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_directEnterButton setTitle:@"直接进入" forState:UIControlStateNormal];
    [_directEnterButton setTitleColor:[UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:_directEnterButton];
    [_directEnterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(_loginButton.mas_bottom).offset(30);
        make.height.equalTo(@50);
    }];
    [_directEnterButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        Glf_TabBarViewController *tabBarVC = [[Glf_TabBarViewController alloc] init];
        [self presentViewController:tabBarVC animated:YES completion:nil];
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
