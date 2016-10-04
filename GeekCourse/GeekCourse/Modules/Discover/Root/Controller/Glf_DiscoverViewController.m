//
//  Glf_DiscoverViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/30.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_DiscoverViewController.h"
#import "Glf_navUpCollectionViewCell.h"
#import "Glf_HandRecordCollectionViewCell.h"
#import "Glf_ProgrammerQuestionCollectionViewCell.h"
#import "Glf_HandRecordCategoryViewController.h"

@interface Glf_DiscoverViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
Glf_HandRecordCollectionViewCellDelegate
>
@property (nonatomic, retain) NSArray *array;
@property (nonatomic, retain) UICollectionView *navCollectionView;
@property (nonatomic, retain) UICollectionView *deepLayerCollectionView;
@property (nonatomic, assign) NSInteger selectedItem;
@end

@implementation Glf_DiscoverViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    self.array = [[NSArray alloc] initWithObjects:@"手记", @"猿问", nil];
    
    [self creatNavCollectionView];
    [self creatDownCollectionView];
}
#pragma mark - 创建 手记 猿问
- (void)creatNavCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 64);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 50, 0, 50);
    self.navCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -20, WIDTH_SCREEN, 64) collectionViewLayout:flowLayout];
    _navCollectionView.backgroundColor = [UIColor whiteColor];
    _navCollectionView.dataSource = self;
    _navCollectionView.delegate = self;
    [self.navigationController.navigationBar addSubview:_navCollectionView];
    [_navCollectionView registerClass:[Glf_navUpCollectionViewCell class] forCellWithReuseIdentifier:@"navUpCell"];
}

#pragma mark - 创建底层 collectionView
- (void)creatDownCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTH_SCREEN, HEIGHT_SCREEN - _navCollectionView.frame.size.height - 50);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.deepLayerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - 64 - 50) collectionViewLayout:flowLayout];
    _deepLayerCollectionView.backgroundColor = [UIColor whiteColor];
    _deepLayerCollectionView.pagingEnabled = YES;
    _deepLayerCollectionView.dataSource = self;
    _deepLayerCollectionView.delegate = self;
    _deepLayerCollectionView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_deepLayerCollectionView];
    
    [_deepLayerCollectionView registerClass:[Glf_HandRecordCollectionViewCell class] forCellWithReuseIdentifier:@"handRecCell"];
    [_deepLayerCollectionView registerClass:[Glf_ProgrammerQuestionCollectionViewCell class] forCellWithReuseIdentifier:@"programmerQuesCell"];
}

#pragma mark - collectionView 协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _navCollectionView) {
        Glf_navUpCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"navUpCell" forIndexPath:indexPath];
        cell.title = _array[indexPath.row];
        return cell;
    }
    if (0 == indexPath.item) {
        Glf_HandRecordCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"handRecCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.backgroundColor = [UIColor redColor];
        return cell;
    } else {
        Glf_ProgrammerQuestionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"programmerQuesCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor blueColor];
        return cell;
    }
}

#pragma mark - navCollectionView 关联 deepLayerConllectionView
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _navCollectionView) {
        
        Glf_navUpCollectionViewCell *notSelectedCell = (Glf_navUpCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedItem inSection:0]];
        
        [notSelectedCell changeOrNot:NO];
        
        Glf_navUpCollectionViewCell *selectedCell = (Glf_navUpCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [selectedCell changeOrNot:YES];
        
        _selectedItem = indexPath.item;
        
        _deepLayerCollectionView.contentOffset = CGPointMake(WIDITH * indexPath.item, 0);
    }
}

#pragma mark - deepLayerCollectionView 关联 navCollection
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger count = _deepLayerCollectionView.contentOffset.x / WIDITH;
    
    [self.navCollectionView setContentOffset:CGPointMake(count, 0)];
    
    NSIndexPath *index = [NSIndexPath indexPathForItem:count inSection:0];
    
    Glf_navUpCollectionViewCell *cell = (Glf_navUpCollectionViewCell *)[_navCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedItem inSection:0]];
    [cell changeOrNot:NO];
    
    Glf_navUpCollectionViewCell *nextCell = (Glf_navUpCollectionViewCell *)[_navCollectionView cellForItemAtIndexPath:index];
    [nextCell changeOrNot:YES];
    
    _selectedItem = index.item;
    
}

#pragma mark - 实现自定义协议
- (void)pushHandRecordViewController {
    Glf_HandRecordCategoryViewController *handRecordVC= [[Glf_HandRecordCategoryViewController alloc] init];
    [self presentViewController:handRecordVC animated:YES completion:nil];
}

@end
