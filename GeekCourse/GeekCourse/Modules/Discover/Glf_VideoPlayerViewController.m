//
//  Glf_VideoPlayerViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/14.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_VideoPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "XCAVPlayerView.h"
#import "Glf_videoListModel.h"
#import "UILabel+Glf_SizeToFit_W_H.h"
#import "UIBarButtonItem+SetImage_Click.h"

@interface Glf_VideoPlayerViewController ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) XCAVPlayerView *playerView;
@property (nonatomic, strong) UIView *downPlayerView;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) NSMutableArray *videoArray;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation Glf_VideoPlayerViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
}

- (XCAVPlayerView *)playerView{
    if (!_playerView) {
        _playerView = [[XCAVPlayerView alloc]init];
    }
    return _playerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem getBarButtonItemWithImage:[UIImage imageNamed:@"back-1"] target:^{
        [_playerView pause];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - 64)];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backgroundView];
    
    self.dataDic = [NSMutableDictionary dictionary];
    self.videoArray = [NSMutableArray array];
    
    [self getVideoData];
    [self creatVideoPlayer];
    [self creatVideoInfo];
    
}

- (void)getVideoData {
    NSString *url = [NSString stringWithFormat:@"http://c.open.163.com/mob/%@/getMoviesForIpad.do", _plid];
    [super getWithURL:url block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        _dataDic = dic[@"data"];
        
        NSMutableArray *videoListArray = _dataDic[@"videoList"];
        for (NSDictionary *dic in videoListArray) {
            Glf_videoListModel *model = [Glf_videoListModel modelWithDic:dic];
            [self.videoArray addObject:model];
        }
        Glf_videoListModel *model = _videoArray[0];
        self.playerView.playerUrl = [NSURL URLWithString:model.mp4SdUrl];
        [self.playerView play];
        
        _titleLabel.text = _dataDic[@"title"];
        _subTitleLabel.text = _dataDic[@"type"];
        _descriptionLabel.text = _dataDic[@"description"];
        
        CGFloat height = [UILabel getHeightByWidth:(WIDTH_SCREEN - 50) title:_descriptionLabel.text font:_descriptionLabel.font];
        
        [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_backgroundView).offset(30);
            make.right.equalTo(_backgroundView).offset(-30);
            make.top.equalTo(_subTitleLabel.mas_bottom).offset(0);
            make.height.equalTo(@(height));
        }];
        
    }];
    
}

- (void)creatVideoPlayer {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(statuesBarChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    self.downPlayerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, WIDTH_SCREEN * 0.6)];
    [_backgroundView addSubview:_downPlayerView];
    self.playerView.frame = _downPlayerView.bounds;
    [_downPlayerView addSubview:self.playerView];
    
}

- (void)creatVideoInfo {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    [_backgroundView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backgroundView).offset(20);
        make.right.equalTo(_backgroundView).offset(-20);
        make.top.equalTo(_downPlayerView.mas_bottom).offset(10);
        make.height.equalTo(@30);
    }];
    
    _subTitleLabel = [[UILabel alloc] init];
    _subTitleLabel.font = [UIFont systemFontOfSize:20];
    [_backgroundView addSubview:_subTitleLabel];
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backgroundView).offset(30);
        make.right.equalTo(_backgroundView).offset(-20);
        make.top.equalTo(_titleLabel.mas_bottom).offset(0);
        make.height.equalTo(@30);
    }];
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.font = [UIFont systemFontOfSize:18];
    _descriptionLabel.numberOfLines = 0;
    [_descriptionLabel sizeToFit];
    [_backgroundView addSubview:_descriptionLabel];
    
}

- (void)statuesBarChanged:(NSNotification *)sender{
    //    UIInterfaceOrientation statues = [UIApplication sharedApplication].statusBarOrientation;
    //    if (statues == UIInterfaceOrientationPortrait || statues == UIInterfaceOrientationPortraitUpsideDown) {
    //        self.playerView.frame = CGRectMake(0, 20.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.58);
    //    }else if (statues == UIInterfaceOrientationLandscapeLeft || statues == UIInterfaceOrientationLandscapeRight){
    //        self.playerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
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
