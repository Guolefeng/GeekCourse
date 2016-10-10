//
//  Glf_RootPlayerViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_RootPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "XCAVPlayerView.h"
#import "Glf_NavCollectionViewCell.h"
#import "Glf_ChaptersCollectionViewCell.h"
#import "Glf_CommentCollectionViewCell.h"
#import "Glf_DetailInfoCollectionView.h"
#import "Glf_ChaptersDataModel.h"
#import "Glf_ChaptersMediaModel.h"
#import "UIBarButtonItem+SetImage_Click.h"

@interface Glf_RootPlayerViewController ()

<
UICollectionViewDataSource,
UICollectionViewDelegate,
Glf_ChaptersCollectionViewCellDelegate,
Glf_DetailInfoCollectionViewDelegate
>
@property (nonatomic, assign) NSInteger selectedItem;

@property (nonatomic, strong) XCAVPlayerView *playerView;

@property (nonatomic, retain) UIView *downPlayerView;

@property (nonatomic, retain) UICollectionView *navCollectionView;

@property (nonatomic, retain) NSMutableArray *navMutableArray;

@property (nonatomic, retain) UICollectionView *contectCollectionView;

@property (nonatomic, retain) NSMutableArray *chaptersModel;

@property (nonatomic, assign) NSInteger mark;
@end

@implementation Glf_RootPlayerViewController

- (XCAVPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[XCAVPlayerView alloc] init];
    }
    return _playerView;
}

#pragma mark - ChapterCollectionViewCell 协议
- (void)changeVideoWith:(NSString *)media_url {
    _playerView.playerUrl = [NSURL URLWithString:media_url];
    [_playerView play];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1.0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navMutableArray = [[NSMutableArray alloc] initWithObjects:@"章节", @"评论", @"详情", nil];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem getBarButtonItemWithImage:[UIImage imageNamed:@"back-1"] target:^{
        [self.navigationController popViewControllerAnimated:YES];
        [_playerView pause];
    }];
    
    self.mark = 0;
    self.chaptersModel = [NSMutableArray array];
    
    [self getVideoChaptersData];
    
    [self creatPlayerView];
    
    [self creatNavCollectionView];
    [self creatContentCollectionView];
    
}

#pragma mark - 获取视屏数据
- (void)getVideoChaptersData {
    NSString *url = @"http://www.imooc.com/api3/getcpinfo_ver2";
    
    NSString *body = [NSString stringWithFormat:@"IMid=16092022365416&cid=%@&token=115f77db60b36ab780fd914850b38b8e&uid=4017288", self.cid];
    
    [super postWithURL:url body:body block:^(id result) {

        NSDictionary *dic = (NSDictionary *)result;
        NSArray *arr = dic[@"data"];
        for (NSDictionary *dic in arr) {
            Glf_ChaptersDataModel *model = [Glf_ChaptersDataModel modelWithDic:dic];
            [_chaptersModel addObject:model];
        }
        [_contectCollectionView reloadData];
        
    }];
}

#pragma mark - 创建视屏播放视图
- (void)creatPlayerView {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statuesBarChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    self.downPlayerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN * 0.3)];
    _downPlayerView.backgroundColor = [UIColor colorWithRed:0.66 green:0.69 blue:0.68 alpha:1.0];
    [self.view addSubview:_downPlayerView];
    
    self.playerView.frame = _downPlayerView.bounds;
    [_downPlayerView addSubview:_playerView];
}
- (void)statuesBarChanged:(NSNotification *)sender{
    //    UIInterfaceOrientation statues = [UIApplication sharedApplication].statusBarOrientation;
    //    if (statues == UIInterfaceOrientationPortrait || statues == UIInterfaceOrientationPortraitUpsideDown) {
    //        self.playerView.frame = CGRectMake(0, 20.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.58);
    //    }else if (statues == UIInterfaceOrientationLandscapeLeft || statues == UIInterfaceOrientationLandscapeRight){
    //        self.playerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //    }
}

#pragma mark - 创建视屏播放下的导航栏
- (void)creatNavCollectionView {
   
    UICollectionViewFlowLayout *navFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    navFlowLayout.itemSize = CGSizeMake((WIDTH_SCREEN - 12 * 4) / 3, 50);
    navFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    self.navCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _downPlayerView.bounds.size.height + 20, WIDTH_SCREEN, 50) collectionViewLayout:navFlowLayout];
    _navCollectionView.dataSource = self;
    _navCollectionView.delegate = self;
    _navCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navCollectionView];
    
    [_navCollectionView registerClass:[Glf_NavCollectionViewCell class] forCellWithReuseIdentifier:@"navCell"];
}

#pragma mark - 创建导航栏下边的 collectionView
- (void)creatContentCollectionView {
    UICollectionViewFlowLayout *contentFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    contentFlowLayout.itemSize = CGSizeMake(WIDTH_SCREEN, HEIGHT_SCREEN - _playerView.frame.size.height - _navCollectionView.frame.size.height - 20);
    contentFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    contentFlowLayout.minimumLineSpacing = 0;
    
    self.contectCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _playerView.frame.size.height + _navCollectionView.frame.size.height + 20, WIDTH_SCREEN, HEIGHT_SCREEN - _playerView.frame.size.height - _navCollectionView.frame.size.height - 20) collectionViewLayout:contentFlowLayout];
    _contectCollectionView.dataSource = self;
    _contectCollectionView.delegate = self;
    _contectCollectionView.pagingEnabled = YES;
    [self.view addSubview:_contectCollectionView];
    
    [_contectCollectionView registerClass:[Glf_ChaptersCollectionViewCell class] forCellWithReuseIdentifier:@"chaptersCell"];
    [_contectCollectionView registerClass:[Glf_CommentCollectionViewCell class] forCellWithReuseIdentifier:@"commentCell"];
    [_contectCollectionView registerClass:[Glf_DetailInfoCollectionView class] forCellWithReuseIdentifier:@"detailInfoCell"];
}

#pragma mark - collectionView 常规协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_mark == 2) {
        if (_chaptersModel.count != 0) {
            
            Glf_ChaptersDataModel *model = _chaptersModel[0];
            
            if (model.media.count != 0) {
                
                Glf_ChaptersMediaModel *mediaModel = model.media[0];
                
                NSString *url = mediaModel.media_url;
                
                self.playerView.playerUrl = [NSURL URLWithString:url];
                [_playerView play];
            }
            
        }

    }
    _mark++;
    
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (collectionView == _navCollectionView) {
        Glf_NavCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"navCell" forIndexPath:indexPath];
        cell.title = _navMutableArray[indexPath.row];
        return cell;
    }
    
    if (0 == indexPath.row) {
        Glf_ChaptersCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"chaptersCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.cid = _cid;
        return cell;
    }
    if (1 == indexPath.row) {
        Glf_CommentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"commentCell" forIndexPath:indexPath];
        cell.cid = _cid;
        return cell;
    }
    else {
        Glf_DetailInfoCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailInfoCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.cid = _cid;
        return cell;
    }
}

#pragma mark - Glf_DetailInfoCollectionView 协议
- (void)playTheVedioWithCid:(NSString *)cid {
    Glf_RootPlayerViewController *rootPlayerVC = [[Glf_RootPlayerViewController alloc] init];
    rootPlayerVC.cid = cid;
    [self.navigationController pushViewController:rootPlayerVC animated:YES];
    
    // 播放暂停
    [_playerView pause];
}

#pragma mark - 导航栏关联 ContentCollectionView
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (collectionView == _navCollectionView) {
        
        Glf_NavCollectionViewCell *notSelectedCell = (Glf_NavCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedItem inSection:0]];
        [notSelectedCell changeSurfaceWith:NO];
        
        Glf_NavCollectionViewCell *selectedCell = (Glf_NavCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [selectedCell changeSurfaceWith:YES];
        
        _selectedItem = indexPath.item;
        
        _contectCollectionView.contentOffset = CGPointMake(WIDITH * indexPath.item, 0);
    }
}

#pragma mark - contentCollectionView 关联导航栏
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger count = (NSInteger)_contectCollectionView.contentOffset.x / WIDITH;
    
    [self.navCollectionView setContentOffset:CGPointMake(count, 0)];
    
    NSIndexPath *index = [NSIndexPath indexPathForItem:count inSection:0];
    
    Glf_NavCollectionViewCell *cell = (Glf_NavCollectionViewCell *)[_navCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedItem inSection:0]];
    [cell changeSurfaceWith:NO];
    
    Glf_NavCollectionViewCell *nextCell = (Glf_NavCollectionViewCell *)[_navCollectionView cellForItemAtIndexPath:index];
    [nextCell changeSurfaceWith:YES];
    
    _selectedItem = index.item;
}

@end
