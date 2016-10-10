//
//  Glf_PractiseViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/25.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_PractiseViewController.h"
#import "Glf_PractiseCollectionViewCell.h"
#import "Glf_PractiseModel.h"

@interface Glf_PractiseViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, retain) NSMutableArray *parctiseModelArray;

@end

@implementation Glf_PractiseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
    // 观察者
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.title = @"实战课程";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [super setLeftBarButtonItem];
    
    self.parctiseModelArray = [NSMutableArray array];
    
    [self getPractiseData];
    
    [self creatCollectionView];
    
    [self creatCarouselView];
}

- (void)getUpData {
    [_parctiseModelArray removeAllObjects];
    
    [self.collectionView reloadData];
    [self getPractiseData];
}

- (void)getPractiseData {
    
    [super postWithURL:@"http://coding.imooc.com/api/szlist" body:@"cid=0&page=1&pagesize=20&timestamp=1475889688200&token=f36593bacd79f78cc11e5a85451351ac&uid=0" block:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        NSArray *array = dic[@"data"];
        for (NSDictionary *dic in array) {
            Glf_PractiseModel *model = [Glf_PractiseModel modelWithDic:dic];
            [_parctiseModelArray addObject:model];
        }
        [_collectionView reloadData];
    }];
    
}

#pragma mark - 创建轮播图 
- (void)creatCarouselView {
    
    NSMutableArray *carouseImageArray = [[NSMutableArray alloc] initWithObjects:@"a.jpg", @"b.jpg", @"c.jpg", @"d.jpg", @"e.jpg", nil];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -200, WIDITH, 200)];
    headerView.backgroundColor = [UIColor yellowColor];
    [_collectionView addSubview:headerView];
    
    [super creatScrollViewWithImageNameArray:carouseImageArray frame:headerView.frame view:_collectionView];
}
#pragma mark - 创建 collectionView
- (void)creatCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((WIDITH - 10 * 3) / 2, (HEIGHT - 10 * 3) / 3);
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDITH, HEIGHT - 64) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    
    _collectionView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    // 下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getUpData];
        [self.collectionView.mj_header endRefreshing];
    }];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[Glf_PractiseCollectionViewCell class] forCellWithReuseIdentifier:@"practiseCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _parctiseModelArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Glf_PractiseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"practiseCell" forIndexPath:indexPath];
    Glf_PractiseModel *model = _parctiseModelArray[indexPath.row];
    cell.model = model;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
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
