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

@interface Glf_JobHuntingViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic, retain) UIImageView *backgroundImageView;

@property (nonatomic, retain) UICollectionView *UpCollectionView;

@property (nonatomic, retain) NSMutableArray *modelArray;

@end

@implementation Glf_JobHuntingViewController

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor cyanColor];
    self.title = @"求职路线计划";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.modelArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getJobHuntingData];
    
    // 创建背景图片
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _backgroundImageView.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = [self getBackgroundimageData];
    
    NSURL *url = [NSURL URLWithString:arr[1]];
    [_backgroundImageView sd_setImageWithURL:url];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = _backgroundImageView.bounds;
    [_backgroundImageView addSubview:effectView];
    
    [self.view addSubview:_backgroundImageView];
    
    [self creatUpCollectionView];
    
}

#pragma mark - 求职路线的数据
- (void)getJobHuntingData {
    [super postWithURL:@"http://www.imooc.com/api3/program" body:@"token=81743025655027bc74b20b49ff5a56f5&typeid=1&uid=0" block:^(id result) {
        NSLog(@"result %@", result);
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *array = dic[@"data"];
        
        for (NSDictionary *dic in array) {
            Glf_JobHuntingModel *model = [Glf_JobHuntingModel modelWithDic:dic];
            [_modelArray addObject:model];
        }
        [_UpCollectionView reloadData];
    }];
}

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
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTH_SCREEN - 100, HEIGHT_SCREEN * 0.7);
    flowLayout.minimumLineSpacing = 30;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 50, 0, 50);
    
    self.UpCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, HEIGHT_SCREEN * 0.2, WIDTH_SCREEN, HEIGHT_SCREEN * 0.6) collectionViewLayout:flowLayout];
    _UpCollectionView.dataSource = self;
    _UpCollectionView.delegate = self;
    _UpCollectionView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0];
    _UpCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_UpCollectionView];
    
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
