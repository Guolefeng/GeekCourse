//
//  Glf_HandRecordCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_HandRecordCollectionViewCell.h"
#import "Glf_navUpCollectionViewCell.h"
#import "Glf_deepCollectionViewCell.h"
#import "Glf_BaseViewController.h"
#import "Glf_HandRecordModel.h"
@interface Glf_HandRecordCollectionViewCell ()

<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, retain) UICollectionView *navCollectionView;
@property (nonatomic, retain) NSMutableArray *navArray;
@property (nonatomic, assign) NSInteger selectedItem;
@property (nonatomic, retain) UICollectionView *deepCollectionView;

@property (nonatomic, retain) Glf_BaseViewController *baseVC;
@property (nonatomic, retain) NSMutableArray *recordModelArray;
@property (nonatomic, retain) NSMutableArray *latestModelArray;
@end

@implementation Glf_HandRecordCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _baseVC = [[Glf_BaseViewController alloc] init];
        _recordModelArray = [NSMutableArray array];
        _latestModelArray = [NSMutableArray array];
        self.navArray = [NSMutableArray arrayWithObjects:@"推荐", @"最新", nil];
        
        [self getHandRecordRecommendData];
        [self getHandRecordLatestData];
        
        [self creatNavCollctionView];
        [self creatDeepCollectionView];
        [self creatCategoryButton];
    }
    return self;
}


#pragma mark - 获取推荐数据
- (void)getHandRecordRecommendData {
    NSString *url = @"http://www.imooc.com/api3/articlelist";
    NSString *body = @"page=1&token=a264b309972ad07cdee3697592024346&type=1&typeid=0&uid=3859703";
    [_baseVC postWithURL:url body:body block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *arr = dic[@"data"];
        
        for (NSDictionary *dic in arr) {
            Glf_HandRecordModel *model = [Glf_HandRecordModel modelWithDic:dic];
            [_recordModelArray addObject:model];
        }
        
        [self creatDeepCollectionView];
    }];
}

#pragma mark - 获取最新数据
- (void)getHandRecordLatestData {
    NSString *url = @"http://www.imooc.com/api3/articlelist";
    NSString *body = @"page=1&token=a264b309972ad07cdee3697592024346&type=0&typeid=0&uid=3859703";
    [_baseVC postWithURL:url body:body block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *arr = dic[@"data"];
        
        for (NSDictionary *dic in arr) {
            Glf_HandRecordModel *model = [Glf_HandRecordModel modelWithDic:dic];
            [_latestModelArray addObject:model];
        }
        
        [self creatDeepCollectionView];
    }];

}

#pragma mark - 创建分类
- (void)creatCategoryButton {
    UIButton *categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    categoryButton.frame = CGRectMake(WIDTH_SCREEN - 60, 10, 30, 30);
    [categoryButton setBackgroundImage:[UIImage imageNamed:@"handSort"] forState:UIControlStateNormal];
    [categoryButton addTarget:self action:@selector(categoryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_navCollectionView addSubview:categoryButton];
}

#pragma mark - 创建 navCollectionView
- (void)creatNavCollctionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 50);
    
    self.navCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 50) collectionViewLayout:flowLayout];
    _navCollectionView.dataSource = self;
    _navCollectionView.delegate = self;
    _navCollectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_navCollectionView];
    [_navCollectionView registerClass:[Glf_navUpCollectionViewCell class] forCellWithReuseIdentifier:@"handNavCell"];
}


#pragma mark - 创建 deepCollectionView
- (void)creatDeepCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTH_SCREEN, self.contentView.frame.size.height - 50);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.deepCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, WIDTH_SCREEN, self.contentView.frame.size.height - 50) collectionViewLayout:flowLayout];
    _deepCollectionView.dataSource = self;
    _deepCollectionView.delegate = self;
    _deepCollectionView.showsHorizontalScrollIndicator = NO;
    _deepCollectionView.pagingEnabled = YES;
    [self.contentView addSubview:_deepCollectionView];
    
    [_deepCollectionView registerClass:[Glf_deepCollectionViewCell class] forCellWithReuseIdentifier:@"recommendCell"];
    [_deepCollectionView registerClass:[Glf_deepCollectionViewCell class] forCellWithReuseIdentifier:@"latestCell"];
}

#pragma mark - collectionView 协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _navArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _navCollectionView) {
        Glf_navUpCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"handNavCell" forIndexPath:indexPath];
        cell.title = _navArray[indexPath.item];
        return cell;
    }
    if (0 == indexPath.item) {
        Glf_deepCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recommendCell" forIndexPath:indexPath];
        cell.array = _recordModelArray;
        return cell;
    } else {
        Glf_deepCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"latestCell" forIndexPath:indexPath];
        cell.array = _latestModelArray;
        return cell;
    }
}

#pragma mark - navCollectionView 关联 deepCollectionView
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    if (collectionView == _navCollectionView) {
        Glf_navUpCollectionViewCell *unSelectedCell = (Glf_navUpCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedItem inSection:0]];
        [unSelectedCell changeOrNot:NO];
        
        Glf_navUpCollectionViewCell *selectedCell = (Glf_navUpCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [selectedCell changeOrNot:YES];
        
        _selectedItem = indexPath.item;
        
        _deepCollectionView.contentOffset = CGPointMake(WIDTH_SCREEN * _selectedItem, 0);
    }
}

#pragma mark - deepCollectionView 关联 navCollectionView 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger count = _deepCollectionView.contentOffset.x / WIDTH_SCREEN;
    self.navCollectionView.contentOffset = CGPointMake(count, 0);
    
    NSIndexPath *index = [NSIndexPath indexPathForItem:count inSection:0];
    
    Glf_navUpCollectionViewCell *unSelectedCell = (Glf_navUpCollectionViewCell *)[_navCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedItem inSection:0]];
    [unSelectedCell changeOrNot:NO];
    
    Glf_navUpCollectionViewCell *selectedCell = (Glf_navUpCollectionViewCell *)[_navCollectionView cellForItemAtIndexPath:index];
    [selectedCell changeOrNot:YES];
    
    _selectedItem = index.item;
}

- (void)categoryButtonAction:(UIButton *)button {
    NSLog(@"分类");
    
    [self.delegate pushHandRecordViewController];
    
}

@end
