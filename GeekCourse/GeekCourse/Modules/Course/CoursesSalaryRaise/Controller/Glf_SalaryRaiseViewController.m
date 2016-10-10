//
//  Glf_SalaryRaiseViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/25.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_SalaryRaiseViewController.h"
#import "Glf_SalaryRaiseHeaderCollectionViewCell.h"
#import "Glf_SalaryCollectionViewCell.h"
#import "Glf_SalaryRaiseModel.h"
#import "Glf_UIWebViewController.h"

@interface Glf_SalaryRaiseViewController ()

<
UICollectionViewDataSource,
UICollectionViewDelegate,
Glf_SalaryCollectionViewCellDelegate
>

@property (nonatomic, retain) UICollectionView *headerCollectionView;
@property (nonatomic, retain) UICollectionView *downLayerCollectionView;

@property (nonatomic, assign) NSInteger selectedItem;

@property (nonatomic, retain) NSMutableArray *allCourseArray;
@property (nonatomic, retain) NSMutableArray *frontEndArray;
@property (nonatomic, retain) NSMutableArray *backEndArray;
@property (nonatomic, retain) NSMutableArray *mobileArray;
@property (nonatomic, retain) NSMutableArray *siteArray;
@end

@implementation Glf_SalaryRaiseViewController

- (NSArray *)getHeaderCellTitle {
    NSArray *array = @[@"全部", @"前端", @"后端", @"移动", @"整站"];
    return array;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // 观察者
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [super setLeftBarButtonItem];
    
    self.view.backgroundColor = [UIColor cyanColor];
    self.title = @"加薪利器计划";
    
    self.allCourseArray = [NSMutableArray array];
    self.frontEndArray = [NSMutableArray array];
    self.backEndArray = [NSMutableArray array];
    self.mobileArray = [NSMutableArray array];
    self.siteArray = [NSMutableArray array];
    
    [self getAllCoursesData];
    [self getFrontEndData];
    [self getBackEndData];
    [self getMobileData];
    [self getSiteData];
    
    [self creatHeaderCollectionView];
    
    [self creatDownLayerCollectionView];
    
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
        [_downLayerCollectionView reloadData];
    }];
    
}

#pragma mark - 获取前端数据
- (void)getFrontEndData {
    
    [super postWithURL:@"http://www.imooc.com/api3/program" body:@" cid=fe&page=1&token=768dbcf2c0bc8198094feeb871ae6409&typeid=2&uid=3859703" block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        
        NSArray *array = dic[@"data"];
        for (NSDictionary *dic in array) {
            Glf_SalaryRaiseModel *model = [Glf_SalaryRaiseModel modelWithDic:dic];
            [_frontEndArray addObject:model];
        }
        [_downLayerCollectionView reloadData];
    }];
}

#pragma mark - 获取后端数据
- (void)getBackEndData {
    
    [super postWithURL:@"http://www.imooc.com/api3/program" body:@" cid=be&page=1&token=75bb61c5cc8a38557388304d64a1b246&typeid=2&uid=4017288" block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        
        NSArray *array = dic[@"data"];
        for (NSDictionary *dic in array) {
            Glf_SalaryRaiseModel *model = [Glf_SalaryRaiseModel modelWithDic:dic];
            [_backEndArray addObject:model];
        }
        [_downLayerCollectionView reloadData];
    }];
}

#pragma mark - 获取移动数据
- (void)getMobileData {
    
    [super postWithURL:@"http://www.imooc.com/api3/program" body:@" cid=mobile&page=1&token=768dbcf2c0bc8198094feeb871ae6409&typeid=2&uid=3859703" block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        
        NSArray *array = dic[@"data"];
        for (NSDictionary *dic in array) {
            Glf_SalaryRaiseModel *model = [Glf_SalaryRaiseModel modelWithDic:dic];
            [_mobileArray addObject:model];
        }
        [_downLayerCollectionView reloadData];
    }];
}

#pragma mark - 获取整站数据
- (void)getSiteData {
    
    [super postWithURL:@"http://www.imooc.com/api3/program" body:@"  cid=fsd&page=1&token=768dbcf2c0bc8198094feeb871ae6409&typeid=2&uid=3859703" block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        
        NSArray *array = dic[@"data"];
        for (NSDictionary *dic in array) {
            Glf_SalaryRaiseModel *model = [Glf_SalaryRaiseModel modelWithDic:dic];
            [_siteArray addObject:model];
        }
        [_downLayerCollectionView reloadData];
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
    downLayerFlowlayout.minimumInteritemSpacing = 0;
    downLayerFlowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.downLayerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _headerCollectionView.frame.size.height, WIDTH_SCREEN, HEIGHT_SCREEN - _headerCollectionView.frame.size.height - 64) collectionViewLayout:downLayerFlowlayout];
    _downLayerCollectionView.pagingEnabled = YES;
    _downLayerCollectionView.dataSource = self;
    _downLayerCollectionView.delegate = self;
    _downLayerCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_downLayerCollectionView];
    
    [_downLayerCollectionView registerClass:[Glf_SalaryCollectionViewCell class] forCellWithReuseIdentifier:@"allCourseCell"];
    [_downLayerCollectionView registerClass:[Glf_SalaryCollectionViewCell class] forCellWithReuseIdentifier:@"frontEndCell"];
    [_downLayerCollectionView registerClass: [Glf_SalaryCollectionViewCell class]forCellWithReuseIdentifier:@"backEndCell"];
    [_downLayerCollectionView registerClass:[Glf_SalaryCollectionViewCell class] forCellWithReuseIdentifier:@"mobileCell"];
    [_downLayerCollectionView registerClass:[Glf_SalaryCollectionViewCell class] forCellWithReuseIdentifier:@"siteCell"];
}

#pragma mark - collectionView 协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _headerCollectionView) {
        Glf_SalaryRaiseHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headerCell" forIndexPath:indexPath];
        NSArray *headerTitleArray = [self getHeaderCellTitle];
        cell.title = headerTitleArray[indexPath.row];
        return cell;
    }
    
    if (indexPath.item == 0) {
        Glf_SalaryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"allCourseCell" forIndexPath:indexPath];
        cell.delegate = self;
        if (_allCourseArray.count != 0) {
            
            cell.array = _allCourseArray;
        }
        
        return cell;
    }
    if (indexPath.item == 1) {
        Glf_SalaryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"frontEndCell" forIndexPath:indexPath];
        cell.delegate = self;
        if (_frontEndArray.count != 0) {
            cell.array = _frontEndArray;
        }
        
        return cell;
    }
    if (indexPath.item == 2) {
        Glf_SalaryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"backEndCell" forIndexPath:indexPath];
        cell.array = _backEndArray;
        cell.delegate = self;
        return cell;
    }
    if (indexPath.item == 3) {
        Glf_SalaryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mobileCell" forIndexPath:indexPath];
        cell.array = _mobileArray;
        cell.delegate = self;
        return cell;
    }
    else {
        Glf_SalaryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"siteCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.array = _siteArray;
        return cell;
    }
}

#pragma mark - 自定义协议方法
- (void)pushWebViewWith:(NSInteger)item array:(NSMutableArray *)array {
    
    Glf_SalaryRaiseModel *model = array[item];
    Glf_UIWebViewController *webVC = [[Glf_UIWebViewController alloc] init];
    webVC.urlString = [NSString stringWithFormat:@"http://www.imooc.com/course/programdetail/pid/%@", model.id_list];
    [self.navigationController pushViewController:webVC animated:YES];
    
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
