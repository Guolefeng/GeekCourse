//
//  Glf_MineViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/2.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_MineViewController.h"
#import "Glf_MineCollectionViewCell.h"
#import "UIButton+Block.h"
#import "Glf_LoginViewController.h"
#import "Glf_SettingViewController.h"

@interface Glf_MineViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic, retain) UICollectionView *downCollectionView;
@property (nonatomic, retain) NSMutableArray *imageViewNameArray;
@property (nonatomic, retain) NSMutableArray *labelNameArray;
@property (nonatomic, retain) NSMutableArray *mineInfoArray;

@end

@implementation Glf_MineViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackToTabBarViewController" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageViewNameArray = [[NSMutableArray alloc] initWithObjects:@"curriculum.png", @"plan.png", @"messages.png", @"notebook.png", @"Bloc_notes.png", @"questions.png", nil];
    self.labelNameArray = [[NSMutableArray alloc] initWithObjects:@"关注的课程", @"我的计划", @"我的消息", @"我的手记", @"我的笔记", @"我的猿问", nil];
    self.mineInfoArray = [NSMutableArray array];
    
    [self creatBackgroundImageViewAndMyInfo];
    
    [self creatDownCollectionView];
    
    [self setNightMode];
}
- (void)setNightMode {
    
    [_downCollectionView jxl_setDayMode:^(UIView *view) {
        view.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        view.backgroundColor = [UIColor blackColor];
    }];
    
    [self.tabBarController.tabBar jxl_setDayMode:^(UIView *view) {
        UITabBar *bar = (UITabBar *)view;
        bar.barTintColor = [UIColor whiteColor];
        bar.barStyle = UIBarStyleDefault;
        
    } nightMode:^(UIView *view) {
        UITabBar *bar = (UITabBar *)view;
        bar.barTintColor = [UIColor blackColor];
        bar.barStyle = UIBarStyleBlack;
    }];
    
    Glf_MineCollectionViewCell *cell = [[Glf_MineCollectionViewCell alloc] init];
    [cell jxl_setDayMode:^(UIView *view) {
        cell.label.textColor = [UIColor blackColor];
    } nightMode:^(UIView *view) {
        cell.label.textColor = [UIColor colorWithRed:0 green:1.0 blue:1.0 alpha:1.0];
    }];
}

#pragma mark - 创建背景图片 及 我的信息布局
- (void)creatBackgroundImageViewAndMyInfo {
    // 背景
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, WIDTH_SCREEN, HEIGHT_SCREEN * 0.6)];
    if (_mineInfoArray.count) {
        imageView.image = [UIImage imageNamed:@"Hope"];
    } else {
        imageView.image = [UIImage imageNamed:@"blurBack"];
    }
    
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = imageView.bounds;
    [imageView addSubview:effectView];
    
    // 设置
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.frame = CGRectMake(WIDTH_SCREEN - 60, 64, 30, 30);
    [settingButton setBackgroundImage:[UIImage imageNamed:@"Setting"] forState:UIControlStateNormal];
    [settingButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        Glf_SettingViewController *settingVC = [[Glf_SettingViewController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }];
    [imageView addSubview:settingButton];
    
   
    // 通知
    UIButton *notifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    notifyButton.frame = CGRectMake(WIDTH_SCREEN - 120, 64, 30, 30);
    [notifyButton setBackgroundImage:[UIImage imageNamed:@"notify"] forState:UIControlStateNormal];
    [notifyButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        NSLog(@"通知");
    }];
    [imageView addSubview:notifyButton];
    
    // 头像
    UIImageView *headSculpture = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_SCREEN * 0.5 - 60, 100, 120, 120)];
    if (_mineInfoArray.count) {
        headSculpture.image = [UIImage imageNamed:@"Hope"];
    } else {
        headSculpture.image = [UIImage imageNamed:@"headImage"];
    }
    
    headSculpture.layer.cornerRadius = headSculpture.frame.size.width * 0.5;
    headSculpture.clipsToBounds = YES;
    [imageView addSubview:headSculpture];
    
    if (_mineInfoArray.count) {
        // 昵称
        UILabel *nicknameLabel = [[UILabel alloc] init];
        nicknameLabel.textAlignment = NSTextAlignmentCenter;
        nicknameLabel.textColor = [UIColor whiteColor];
        nicknameLabel.text = @"慕粉1474250115";
        nicknameLabel.font = [UIFont systemFontOfSize:25];
        [imageView addSubview:nicknameLabel];
        [nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headSculpture).offset(0);
            make.top.equalTo(headSculpture.mas_bottom).offset(10);
            make.width.equalTo(@(headSculpture.frame.size.width * 2));
            make.height.equalTo(@50);
        }];
        
        // 签名
        UILabel *signature = [[UILabel alloc] init];
        signature.text = @"这个家伙很懒, 什么也没有留下~";
        signature.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        signature.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:signature];
        [signature mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(nicknameLabel).offset(0);
            make.width.equalTo(@(headSculpture.frame.size.width * 3));
            make.top.equalTo(nicknameLabel.mas_bottom).offset(10);
            make.height.equalTo(@50);
        }];
        
        // 学习
        
        UILabel *learningLabel = [[UILabel alloc] init];
        learningLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        learningLabel.textAlignment = NSTextAlignmentCenter;
        learningLabel.text = @"学习";
        [imageView addSubview:learningLabel];
        [learningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(signature.mas_bottom).offset(20);
            make.left.equalTo(imageView).offset(30);
            make.height.equalTo(@30);
            make.width.equalTo(@100);
        }];
        
        UILabel *learningDownLabel = [[UILabel alloc] init];
        learningDownLabel.text = @"3小时";
        learningDownLabel.textColor = [UIColor whiteColor];
        learningDownLabel.font = [UIFont systemFontOfSize:25];
        learningDownLabel.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:learningDownLabel];
        [learningDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(learningLabel.mas_bottom).offset(0);
            make.centerX.equalTo(learningLabel).offset(0);
            make.height.equalTo(@50);
            make.width.equalTo(@100);
        }];
        
        UILabel *firstLineLabel = [[UILabel alloc] init];
        firstLineLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        [imageView addSubview:firstLineLabel];
        [firstLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(learningLabel.mas_right).offset(10);
            make.top.equalTo(signature.mas_bottom).offset(30);
            make.width.equalTo(@1);
            make.height.equalTo(@60);
        }];
        
        // 经验
        UILabel *experienceLabel = [[UILabel alloc] init];
        experienceLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        experienceLabel.textAlignment = NSTextAlignmentCenter;
        experienceLabel.text = @"经验";
        [imageView addSubview:experienceLabel];
        [experienceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(signature.mas_bottom).offset(20);
            make.left.equalTo(firstLineLabel.mas_right).offset(10);
            make.height.equalTo(@30);
            make.width.equalTo(@100);
        }];
        
        UILabel *experienceDownLabel = [[UILabel alloc] init];
        experienceDownLabel.text = @"160";
        experienceDownLabel.textColor = [UIColor whiteColor];
        experienceDownLabel.font = [UIFont systemFontOfSize:25];
        experienceDownLabel.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:experienceDownLabel];
        [experienceDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(learningLabel.mas_bottom).offset(0);
            make.centerX.equalTo(experienceLabel).offset(0);
            make.height.equalTo(@50);
            make.width.equalTo(@100);
        }];
        
        
        UILabel *secondLineLabel = [[UILabel alloc] init];
        secondLineLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        [imageView addSubview:secondLineLabel];
        [secondLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(experienceLabel.mas_right).offset(20);
            make.top.equalTo(signature.mas_bottom).offset(30);
            make.width.equalTo(@1);
            make.height.equalTo(@60);
        }];
        
        // 积分
        
        UILabel *scoreLabel = [[UILabel alloc] init];
        scoreLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.text = @"积分";
        [imageView addSubview:scoreLabel];
        [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(signature.mas_bottom).offset(20);
            make.right.equalTo(imageView).offset(-30);
            make.height.equalTo(@30);
            make.width.equalTo(@100);
        }];
        
        UILabel *scoreDownLabel = [[UILabel alloc] init];
        scoreDownLabel.text = @"0";
        scoreDownLabel.textColor = [UIColor whiteColor];
        scoreDownLabel.font = [UIFont systemFontOfSize:25];
        scoreDownLabel.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:scoreDownLabel];
        [scoreDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(learningLabel.mas_bottom).offset(0);
            make.centerX.equalTo(scoreLabel).offset(0);
            make.height.equalTo(@50);
            make.width.equalTo(@100);
        }];
    }
    else {
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        loginButton.layer.cornerRadius = 5;
        loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
        loginButton.layer.borderWidth = 2;
        [imageView addSubview:loginButton];
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headSculpture.mas_centerX).offset(0);
            make.top.equalTo(headSculpture.mas_bottom).offset(100);
            make.width.equalTo(@200);
            make.height.equalTo(@50);
        }];
        
        [loginButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            Glf_LoginViewController *loginVC = [[Glf_LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }];
    }
    
  
    
}

#pragma mark - 创建 downCollectionView
- (void)creatDownCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 0, 20);
    self.downCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, HEIGHT_SCREEN * 0.6 - 64, WIDTH_SCREEN, HEIGHT_SCREEN * 0.4) collectionViewLayout:layout];
    _downCollectionView.dataSource = self;
    _downCollectionView.delegate = self;
    _downCollectionView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0f];
    [self.view addSubview:_downCollectionView];
    
    [_downCollectionView registerClass:[Glf_MineCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageViewNameArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Glf_MineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageName = _imageViewNameArray[indexPath.row];
    cell.labelName = _labelNameArray[indexPath.row];
    return cell;
}

#pragma mark - collectionViewCell 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
}

@end
