//
//  Glf_JobHuntingViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/25.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_JobHuntingViewController.h"
#import "Glf_JobHuntingModel.h"
#import "Glf_UpCollectionViewCell.h"
#import "Glf_MyCollectionViewFlowLayout.h"
#import "Glf_UIWebViewController.h"

@interface Glf_JobHuntingViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic, retain) UIImageView *backgroundImageView;

@property (nonatomic, retain) Glf_MyCollectionViewFlowLayout *flowLayout;
@property (nonatomic, retain) UICollectionView *UpCollectionView;

@property (nonatomic, retain) NSMutableArray *modelArray;

@end

@implementation Glf_JobHuntingViewController

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor cyanColor];
    [super setLeftBarButtonItem];
    
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.modelArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self getJobHuntingData];
    
    NSArray *arr = [self getBackgroundimageData];
    [self creatBackgroudImageViewWith:arr index:0];
    
    [self creatUpCollectionView];
    
}

#pragma mark - 求职路线的数据
- (void)getJobHuntingData {
    [super postWithURL:@"http://www.imooc.com/api3/program" body:@"token=81743025655027bc74b20b49ff5a56f5&typeid=1&uid=0" block:^(id result) {

        NSDictionary *dic = (NSDictionary *)result;
        NSArray *array = dic[@"data"];
        
        for (NSDictionary *dic in array) {
            Glf_JobHuntingModel *model = [Glf_JobHuntingModel modelWithDic:dic];
            [_modelArray addObject:model];
        }
        [_UpCollectionView reloadData];
    }];
}

#pragma mark - 创建背景图片
- (void)creatBackgroudImageViewWith:(NSArray *)array index:(NSInteger)index {
    
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, WIDTH_SCREEN, HEIGHT_SCREEN)];
    _backgroundImageView.userInteractionEnabled = YES;
    
    NSURL *url = [NSURL URLWithString:array[index]];
    [_backgroundImageView sd_setImageWithURL:url];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = _backgroundImageView.bounds;
    [_backgroundImageView addSubview:effectView];
    
    [self.view addSubview:_backgroundImageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    label.text = @"求职路线计划";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:30];
    [_backgroundImageView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.top.equalTo(self.view).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@50);
    }];
    
}

#pragma mark - 获取背景图片数据
- (NSArray *)getBackgroundimageData {
    NSArray *array = @[
                       @"http://img.mukewang.com/56551e2800014fa909600720-960-720.jpg",
                       @"http://img.mukewang.com/56551e450001afcd09600720-960-720.jpg",
                       @"http://img.mukewang.com/56551e5d0001a66209600720-960-720.jpg",
                       @"http://img.mukewang.com/56551e6700018b0c09600720-960-720.jpg",
                       @"http://img.mukewang.com/565681830001c9a309600720-960-720.jpg"
                       ];
    return array;
}

#pragma mark - 创建 upCollectionView
- (void)creatUpCollectionView {
    self.flowLayout = [[Glf_MyCollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(WIDTH_SCREEN - 150, HEIGHT_SCREEN * 0.5);
    _flowLayout.minimumLineSpacing = 50;
    _flowLayout.minimumInteritemSpacing = 10;
    
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 50, 0, 50);
    
    self.UpCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, HEIGHT_SCREEN * 0.2, WIDTH_SCREEN, HEIGHT_SCREEN * 0.6) collectionViewLayout:_flowLayout];
    _UpCollectionView.dataSource = self;
    _UpCollectionView.delegate = self;
    _UpCollectionView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0];
    // 滚动减速效果
    _UpCollectionView.decelerationRate = UIScrollViewDecelerationRateNormal;
    
    _UpCollectionView.showsHorizontalScrollIndicator = NO;
    [_backgroundImageView addSubview:_UpCollectionView];
    
    [_UpCollectionView registerClass:[Glf_UpCollectionViewCell class] forCellWithReuseIdentifier:@"upCell"];

}

#pragma mark - collectionView 协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _modelArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    
    if (collectionView == _UpCollectionView) {
        Glf_UpCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"upCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        Glf_JobHuntingModel *model = _modelArray[indexPath.row];
        cell.model = model;
        
        return cell;
    }
    
    return nil;
}
#pragma mark - collectionView 关联 背景图片
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger count = scrollView.contentOffset.x / _flowLayout.itemSize.width;
    NSArray *arr = [self getBackgroundimageData];
    NSURL *url = [NSURL URLWithString:arr[count]];
    [_backgroundImageView sd_setImageWithURL:url];
}

#pragma mark - collectionViewCell 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 添加一个点击 cell, 将其滚动到中间
    [self.UpCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [self.UpCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
//    Glf_JobHuntingModel *model = _modelArray[indexPath.item];
//    NSLog(@"%@, %ld", model.id_list, indexPath.item);
//    
//    Glf_UIWebViewController *webVC = [[Glf_UIWebViewController alloc] init];
//    webVC.urlString = [NSString stringWithFormat:@"http://www.imooc.com/course/programdetail/pid/%@", model.id_list];
//    [self.navigationController pushViewController:webVC animated:YES];
    
   
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
