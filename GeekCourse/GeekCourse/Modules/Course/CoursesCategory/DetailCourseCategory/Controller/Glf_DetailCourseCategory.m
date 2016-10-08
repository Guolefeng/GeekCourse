//
//  Glf_DetailCourseCategory.m
//  GeekCourse
//
//  Created by dllo on 16/10/8.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_DetailCourseCategory.h"
#import "UIBarButtonItem+SetImage_Click.h"
#import "Glf_DetailCourseNavCollectionViewCell.h"
#import "Glf_DetailCourseDownCollectionViewCell.h"
#import "Glf_ModelOfCourse.h"
#import "Glf_RootPlayerViewController.h"

@interface Glf_DetailCourseCategory ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
Glf_DetailCourseDownCollectionViewCellDelegate
>

@property (nonatomic, retain) UIView *upperView;
@property (nonatomic, retain) NSArray *navArray;
@property (nonatomic, retain) UICollectionView *navCollectionView;
@property (nonatomic, retain) UICollectionView *downCollectionView;
@property (nonatomic, assign) NSInteger selectedItem;

@property (nonatomic, retain) NSMutableArray *allArray;
@property (nonatomic, retain) NSMutableArray *primaryArray;
@property (nonatomic, retain) NSMutableArray *middleArray;
@property (nonatomic, retain) NSMutableArray *seniorArray;
@end

@implementation Glf_DetailCourseCategory

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor cyanColor];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    
    [super setLeftBarButtonItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navArray = [NSArray arrayWithObjects:@"全部", @"初级", @"中级", @"高级", nil];
    self.allArray = [NSMutableArray array];
    self.primaryArray = [NSMutableArray array];
    self.middleArray = [NSMutableArray array];
    self.seniorArray = [NSMutableArray array];
    
    [self getAllData];
    [self getPrimaryData];
    [self getMiddleData];
    [self getSeniorData];
    
    [self creatUpperView];
    [self creatNavCollectionView];
    [self creatDownCollectionView];
}

- (void)getAllData {
    NSInteger allInteger = 0;
    NSString *body = [NSString stringWithFormat:@"all_type=1&cat_type=%@&easy_type=%ld&page=1&sort_type=0&token=8dded8e1a2c78425715aa040f3ccdbd6&uid=4017288", self.cat_type, allInteger];
    [super postWithURL:@"http://www.imooc.com/api3/courselist_ver2" body:body block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *arr = dic[@"data"];
        for (NSDictionary *dic in arr) {
            Glf_ModelOfCourse *model = [Glf_ModelOfCourse modelWithDic:dic];
            [_allArray addObject:model];
        }
        [_downCollectionView reloadData];
    }];
}

- (void)getPrimaryData {
    NSInteger allInteger = 1;
    NSString *body = [NSString stringWithFormat:@"all_type=1&cat_type=%@&easy_type=%ld&page=1&sort_type=0&token=8dded8e1a2c78425715aa040f3ccdbd6&uid=4017288", self.cat_type, allInteger];
    [super postWithURL:@"http://www.imooc.com/api3/courselist_ver2" body:body block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *arr = dic[@"data"];
        for (NSDictionary *dic in arr) {
            Glf_ModelOfCourse *model = [Glf_ModelOfCourse modelWithDic:dic];
            [_primaryArray addObject:model];
        }
        [_downCollectionView reloadData];
    }];
}

- (void)getMiddleData {
    NSInteger allInteger = 2;
    NSString *body = [NSString stringWithFormat:@"all_type=1&cat_type=%@&easy_type=%ld&page=1&sort_type=0&token=8dded8e1a2c78425715aa040f3ccdbd6&uid=4017288", self.cat_type, allInteger];
    [super postWithURL:@"http://www.imooc.com/api3/courselist_ver2" body:body block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *arr = dic[@"data"];
        for (NSDictionary *dic in arr) {
            Glf_ModelOfCourse *model = [Glf_ModelOfCourse modelWithDic:dic];
            [_middleArray addObject:model];
        }
        [_downCollectionView reloadData];
    }];
}

- (void)getSeniorData {
    NSInteger allInteger = 3;
    NSString *body = [NSString stringWithFormat:@"all_type=1&cat_type=%@&easy_type=%ld&page=1&sort_type=0&token=8dded8e1a2c78425715aa040f3ccdbd6&uid=4017288", self.cat_type, allInteger];
    [super postWithURL:@"http://www.imooc.com/api3/courselist_ver2" body:body block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *arr = dic[@"data"];
        for (NSDictionary *dic in arr) {
            Glf_ModelOfCourse *model = [Glf_ModelOfCourse modelWithDic:dic];
            [_seniorArray addObject:model];
        }
        [_downCollectionView reloadData];
    }];
}


#pragma mark - 创建上面的视图
- (void)creatUpperView {
    self.upperView = [[UIView alloc] initWithFrame:CGRectMake(0, -64, WIDTH_SCREEN, 200)];
    _upperView.backgroundColor = [UIColor colorWithRed:0.66 green:0.69 blue:0.68 alpha:1.0];
    [self.view addSubview:_upperView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    NSURL *url = [NSURL URLWithString:self.picUrlString];
    [imageView sd_setImageWithURL:url];
    [_upperView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_upperView.mas_centerX).offset(0);
        make.top.equalTo(_upperView).offset(40);
        make.width.height.equalTo(@100);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = self.name;
    label.font = [UIFont systemFontOfSize:25];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [_upperView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_upperView.mas_centerX).offset(0);
        make.top.equalTo(imageView.mas_bottom).offset(5);
        make.width.equalTo(@150);
        make.height.equalTo(@50);
    }];
}

#pragma mark - 创建导航 CollectionView
- (void)creatNavCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((WIDTH_SCREEN - 50) / 4, 50);
    self.navCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _upperView.frame.size.height - 64, WIDTH_SCREEN, 50) collectionViewLayout:layout];
    _navCollectionView.dataSource = self;
    _navCollectionView.delegate = self;
    _navCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navCollectionView];
    
    [_navCollectionView registerClass:[Glf_DetailCourseNavCollectionViewCell class] forCellWithReuseIdentifier:@"navCell"];
}

#pragma mark - 创建 downCollectionView
- (void)creatDownCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(WIDTH_SCREEN, HEIGHT_SCREEN - _upperView.frame.size.height - _navCollectionView.frame.size.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    self.downCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _upperView.frame.size.height + _navCollectionView.frame.size.height - 64, WIDTH_SCREEN, HEIGHT_SCREEN - _upperView.frame.size.height - _navCollectionView.frame.size.height) collectionViewLayout:layout];
    _downCollectionView.backgroundColor = [UIColor whiteColor];
    _downCollectionView.delegate = self;
    _downCollectionView.dataSource = self;
    _downCollectionView.pagingEnabled = YES;
    [self.view addSubview:_downCollectionView];
    
    [_downCollectionView registerClass:[Glf_DetailCourseDownCollectionViewCell class] forCellWithReuseIdentifier:@"downCell"];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _navArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _navCollectionView) {
        Glf_DetailCourseNavCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"navCell" forIndexPath:indexPath];
        cell.title = _navArray[indexPath.item];
        return cell;
    }
    if (indexPath.item == 0) {
        Glf_DetailCourseDownCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"downCell" forIndexPath:indexPath];
        cell.delegate = self;
        if (_allArray.count != 0) {
            
            cell.array = _allArray;
        }
        
        return cell;
    }
    if (indexPath.item == 1) {
        Glf_DetailCourseDownCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"downCell" forIndexPath:indexPath];
        cell.delegate = self;
        if (_primaryArray.count != 0) {
            
            cell.array = _primaryArray;
        }
        return cell;
    }
    if (indexPath.item == 2) {
        Glf_DetailCourseDownCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"downCell" forIndexPath:indexPath];
        cell.delegate = self;
        if (_middleArray.count != 0) {
            
            cell.array = _middleArray;
        }
        return cell;
    }
    else {
        Glf_DetailCourseDownCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"downCell" forIndexPath:indexPath];
        cell.delegate = self;
        if (_seniorArray.count != 0) {
            
            cell.array = _seniorArray;
        }
        return cell;
    }

}

#pragma mark - navCollectionView 关联 downCollectionView
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (collectionView == _navCollectionView) {
        Glf_DetailCourseNavCollectionViewCell *notSelectedCell = (Glf_DetailCourseNavCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedItem inSection:0]];
        [notSelectedCell changeSurface:NO];
        
        Glf_DetailCourseNavCollectionViewCell *selectedCell = (Glf_DetailCourseNavCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [selectedCell changeSurface:YES];
        
        _selectedItem = indexPath.item;
        
        _downCollectionView.contentOffset = CGPointMake(WIDITH * indexPath.item, 0);
    }
}

#pragma mark - downCollectionView 关联 navCollectionView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger count = (NSInteger)_downCollectionView.contentOffset.x / WIDITH;
    
    NSIndexPath *index = [NSIndexPath indexPathForItem:count inSection:0];
    
    Glf_DetailCourseNavCollectionViewCell *cell = (Glf_DetailCourseNavCollectionViewCell *)[_navCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedItem inSection:0]];
    [cell changeSurface:NO];
    
    Glf_DetailCourseNavCollectionViewCell *nextCell = (Glf_DetailCourseNavCollectionViewCell *)[_navCollectionView cellForItemAtIndexPath:index];
    [nextCell changeSurface:YES];
    
    _selectedItem = index.item;
}

#pragma mark - 自定义协议
- (void)pushPlayerViewController {
    Glf_RootPlayerViewController *rootPlayerVC = [[Glf_RootPlayerViewController alloc] init];
    [self.navigationController pushViewController:rootPlayerVC animated:YES];
}

@end
