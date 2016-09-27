//
//  Glf_SalaryRaiseViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/25.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_SalaryRaiseViewController.h"
#import "Glf_SalaryRaiseHeaderCollectionViewCell.h"
#import "Glf_UpLayerCollectionViewCell.h"
#import "Glf_SalaryRaiseModel.h"

@interface Glf_SalaryRaiseViewController ()

<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, retain) UICollectionView *headerCollectionView;
@property (nonatomic, retain) UICollectionView *downLayerCollectionView;
@property (nonatomic, retain) UICollectionView *upLayerCollectionView;

@property (nonatomic, assign) NSInteger selectedItem;

@property (nonatomic, retain) NSMutableArray *allCourseArray;
@end

@implementation Glf_SalaryRaiseViewController

- (NSArray *)getHeaderCellTitle {
    NSArray *array = @[@"全部", @"前端", @"后端", @"移动", @"整站"];
    return array;
}

- (void)viewWillAppear:(BOOL)animated {
    // 观察者
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    self.title = @"加薪利器计划";
    
    self.allCourseArray = [NSMutableArray array];
    
    [self getAllCoursesData];
    
    [self creatHeaderCollectionView];
    
    [self creatDownLayerCollectionView];
    
    [self creatUpLayerConllectionView];
}

#pragma mark - 获取全部课程数据
- (void)getAllCoursesData {
    
    [super postWithURL:@"http://www.imooc.com/api3/program" body:@" cid=&page=1&token=768dbcf2c0bc8198094feeb871ae6409&typeid=2&uid=3859703" block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        
        NSArray *array = dic[@"data"];
        for (NSDictionary *dic in array) {
            Glf_SalaryRaiseModel *model = [Glf_SalaryRaiseModel modelWithDic:dic];
            [_allCourseArray addObject:model];
        }
        [_upLayerCollectionView reloadData];
    }];
    
}

#pragma mark - 创建 header collectionView
- (void)creatHeaderCollectionView {
    UICollectionViewFlowLayout *headerFlowlayout = [[UICollectionViewFlowLayout alloc] init];
    headerFlowlayout.itemSize = CGSizeMake((WIDTH_SCREEN - 10 * 7 ) / 6, 50);
    headerFlowlayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    self.headerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 50) collectionViewLayout:headerFlowlayout];
    
    _headerCollectionView.backgroundColor = [UIColor whiteColor];
    _headerCollectionView.dataSource = self;
    _headerCollectionView.delegate = self;
    
    [self.view addSubview:_headerCollectionView];
    
    [_headerCollectionView registerClass:[Glf_SalaryRaiseHeaderCollectionViewCell class] forCellWithReuseIdentifier:@"headerCell"];
}

#pragma mark - 创建 downLayerCollectionView
- (void)creatDownLayerCollectionView {
    UICollectionViewFlowLayout *downLayerFlowlayout = [[UICollectionViewFlowLayout alloc] init];
    downLayerFlowlayout.itemSize = CGSizeMake(WIDTH_SCREEN, HEIGHT_SCREEN - _headerCollectionView.frame.size.height);
    downLayerFlowlayout.minimumLineSpacing = 0;
    downLayerFlowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.downLayerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _headerCollectionView.frame.size.height, WIDTH_SCREEN, HEIGHT_SCREEN - _headerCollectionView.frame.size.height - 64) collectionViewLayout:downLayerFlowlayout];
    _downLayerCollectionView.pagingEnabled = YES;
    _downLayerCollectionView.dataSource = self;
    _downLayerCollectionView.delegate = self;
    _downLayerCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_downLayerCollectionView];
    
    [_downLayerCollectionView registerClass:[Glf_UpLayerCollectionViewCell class] forCellWithReuseIdentifier:@"downLayerCell"];
}

#pragma mark - 创建 upLayerConllectionView
- (void)creatUpLayerConllectionView {
    UICollectionViewFlowLayout *upLayerFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    upLayerFlowLayout.itemSize = CGSizeMake((WIDTH_SCREEN - 10 * 3) / 2, (HEIGHT_SCREEN - 64 - _headerCollectionView.bounds.size.height - 10 * 3) / 2);
    upLayerFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    
    self.upLayerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - _headerCollectionView.bounds.size.height - 64) collectionViewLayout:upLayerFlowLayout];
    _upLayerCollectionView.backgroundColor = [UIColor lightGrayColor];
    _upLayerCollectionView.dataSource = self;
    _upLayerCollectionView.delegate = self;
    
    [_downLayerCollectionView addSubview:_upLayerCollectionView];
    
    [_upLayerCollectionView registerClass:[Glf_UpLayerCollectionViewCell class] forCellWithReuseIdentifier:@"allCourseCell"];
    
}

#pragma mark - collectionView 协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger num = 0;
    if (collectionView == _headerCollectionView) {
        num = 5;
    }
    if (collectionView == _downLayerCollectionView) {
        num = 5;
    }
    if (collectionView == _upLayerCollectionView) {
        num = _allCourseArray.count;
    }
    return num;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _headerCollectionView) {
        Glf_SalaryRaiseHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headerCell" forIndexPath:indexPath];
        NSArray *headerTitleArray = [self getHeaderCellTitle];
        cell.title = headerTitleArray[indexPath.row];
        return cell;
    }
    
    if (collectionView == _downLayerCollectionView) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"downLayerCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.f green:arc4random() % 256 / 255.f blue:arc4random() % 256 / 255.f alpha:1.f];
        return cell;
    }
    
    if (collectionView == _upLayerCollectionView) {
        Glf_UpLayerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"allCourseCell" forIndexPath:indexPath];
        Glf_SalaryRaiseModel *model = _allCourseArray[indexPath.row];
        cell.salaryRaiseModel = model;
        return cell;
    }
    
    return nil;
}

#pragma mark - headerCollectionView 关联 downLayerConllectionView
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _headerCollectionView) {
        Glf_SalaryRaiseHeaderCollectionViewCell *notSelectedCell = (Glf_SalaryRaiseHeaderCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedItem inSection:0]];
        [notSelectedCell changeSurfaceWith:NO];
        
        Glf_SalaryRaiseHeaderCollectionViewCell *selectedCell = (Glf_SalaryRaiseHeaderCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [selectedCell changeSurfaceWith:YES];
        
        _selectedItem = indexPath.item;
        
        _downLayerCollectionView.contentOffset = CGPointMake(WIDITH * indexPath.item, 0);
    }
}

#pragma mark - downLayerCollectionView 关联 headerCollection
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger count = (NSInteger)_downLayerCollectionView.contentOffset.x / WIDITH;
    
    [self.headerCollectionView setContentOffset:CGPointMake(count, 0)];
    
    NSIndexPath *index = [NSIndexPath indexPathForItem:count inSection:0];
    
    Glf_SalaryRaiseHeaderCollectionViewCell *cell = (Glf_SalaryRaiseHeaderCollectionViewCell *)[_headerCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedItem inSection:0]];
    [cell changeSurfaceWith:NO];
    
    Glf_SalaryRaiseHeaderCollectionViewCell *nextCell = (Glf_SalaryRaiseHeaderCollectionViewCell *)[_headerCollectionView cellForItemAtIndexPath:index];
    [nextCell changeSurfaceWith:YES];
    
    _selectedItem = index.item;
   
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
