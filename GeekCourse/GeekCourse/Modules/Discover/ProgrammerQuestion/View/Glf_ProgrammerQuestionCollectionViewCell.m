//
//  Glf_ProgrammerQuestionCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ProgrammerQuestionCollectionViewCell.h"
#import "Glf_navUpCollectionViewCell.h"
#import "Glf_ProgrammerDeepCollectionViewCell.h"
#import "Glf_BaseViewController.h"
#import "Glf_ProgrammerQuestionModel.h"

@interface Glf_ProgrammerQuestionCollectionViewCell ()

<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, retain) UICollectionView *navCollectionView;
@property (nonatomic, retain) UICollectionView *deepCollectionView;
@property (nonatomic, retain) NSMutableArray *navArray;
@property (nonatomic, assign) NSInteger selectedItem;

@property (nonatomic, retain) Glf_BaseViewController *baseVC;

@property (nonatomic, retain) NSMutableArray *recommendArray;
@property (nonatomic, retain) NSMutableArray *latestArray;
@property (nonatomic, retain) NSMutableArray *waitAnswerArray;

@end

@implementation Glf_ProgrammerQuestionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.navArray = [NSMutableArray arrayWithObjects:@"推荐", @"最新", @"等待回答", nil];
        self.baseVC = [[Glf_BaseViewController alloc] init];
        self.recommendArray = [NSMutableArray array];
        self.latestArray = [NSMutableArray array];
        self.waitAnswerArray = [NSMutableArray array];
        
        [self getRecommendData];
        [self getLatestData];
        [self getWaitAnswerData];
        
        [self creatNavCollctionView];
        [self creatDeepCollectionView];
    }
    return self;
}

#pragma mark - 获取推荐数据
- (void)getRecommendData {
    NSString *url = @"http://www.imooc.com/api3/getrecommend";
    NSString *body = @"page=1&token=a787b1e64184adf72f29c9369cba8ef5&type=recommend&uid=3859703";
    [_baseVC postWithURL:url body:body block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *array = dic[@"data"];
        for (NSDictionary *dic in array) {
            Glf_ProgrammerQuestionModel *model = [Glf_ProgrammerQuestionModel modelWithDic:dic];
            [_recommendArray addObject:model];
        }
        [self creatDeepCollectionView];
    }];
}

#pragma mark - 获取最新数据
- (void)getLatestData {
    NSString *url = @"http://www.imooc.com/api3/getrecommend";
    NSString *body = @"page=1&token=8043e781b9f50f3e10ea79546d2f1090&type=new&uid=4017288";
    [_baseVC postWithURL:url body:body block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *array = dic[@"data"];
        for (NSDictionary *dic in array) {
            Glf_ProgrammerQuestionModel *model = [Glf_ProgrammerQuestionModel modelWithDic:dic];
            [_latestArray addObject:model];
        }
        [self creatDeepCollectionView];
    }];
}

#pragma mark - 获取最新数据
- (void)getWaitAnswerData {
    NSString *url = @"http://www.imooc.com/api3/getrecommend";
    NSString *body = @"page=1&token=8043e781b9f50f3e10ea79546d2f1090&type=waitreply&uid=4017288";
    [_baseVC postWithURL:url body:body block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *array = dic[@"data"];
        for (NSDictionary *dic in array) {
            Glf_ProgrammerQuestionModel *model = [Glf_ProgrammerQuestionModel modelWithDic:dic];
            [_waitAnswerArray addObject:model];
        }
        [self creatDeepCollectionView];
    }];
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
    _deepCollectionView.pagingEnabled = YES;
    _deepCollectionView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:_deepCollectionView];
    
    [_deepCollectionView registerClass:[Glf_ProgrammerDeepCollectionViewCell class] forCellWithReuseIdentifier:@"recommendCell"];
    [_deepCollectionView registerClass:[Glf_ProgrammerDeepCollectionViewCell class] forCellWithReuseIdentifier:@"latestCell"];
    [_deepCollectionView registerClass:[Glf_ProgrammerDeepCollectionViewCell class] forCellWithReuseIdentifier:@"waitAnswerCell"];
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
        Glf_ProgrammerDeepCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recommendCell" forIndexPath:indexPath];
        cell.array = _recommendArray;
        return cell;
    }
    if (1 == indexPath.item) {
        Glf_ProgrammerDeepCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"latestCell" forIndexPath:indexPath];
        cell.array = _latestArray;
        return cell;
    }
    else {
        Glf_ProgrammerDeepCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"waitAnswerCell" forIndexPath:indexPath];
        cell.array = _waitAnswerArray;
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



@end
