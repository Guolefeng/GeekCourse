//
//  Glf_PlayerViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_PlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "XCAVPlayerView.h"

@interface Glf_PlayerViewController ()

@property (nonatomic, strong)XCAVPlayerView *playerView;

@end

@implementation Glf_PlayerViewController

- (XCAVPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[XCAVPlayerView alloc] init];
    }
    return _playerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statuesBarChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    UIView *playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20.0, WIDTH_SCREEN, HEIGHT_SCREEN * 0.3)];
    [self.view addSubview:playerView];
    
    self.playerView.frame = playerView.bounds;
    [playerView addSubview:_playerView];
    self.playerView.playerUrl = [NSURL URLWithString:@"http://v1.mukewang.com/85ab8c5f-2081-4da7-b563-ac1540851f76/L.mp4"];
    [self.playerView play];
}

- (void)statuesBarChanged:(NSNotification *)sender{
    //    UIInterfaceOrientation statues = [UIApplication sharedApplication].statusBarOrientation;
    //    if (statues == UIInterfaceOrientationPortrait || statues == UIInterfaceOrientationPortraitUpsideDown) {
    //        self.playerView.frame = CGRectMake(0, 20.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.58);
    //    }else if (statues == UIInterfaceOrientationLandscapeLeft || statues == UIInterfaceOrientationLandscapeRight){
    //        self.playerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //    }
}

@end
