//
//  Glf_HandRecordCategoryViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_HandRecordCategoryViewController.h"
#import "UIButton+Block.h"
#import "Glf_ChooseToSortModel.h"
#import "Glf_ChooseToSortCell.h"


@interface Glf_HandRecordCategoryViewController ()

<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, retain) NSMutableArray *modelArray;
@property (nonatomic, retain) UICollectionView *collectionView;
@end

@implementation Glf_HandRecordCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    self.modelArray = [NSMutableArray array];
    
    
    [self creatNavBar];
    
    [self getCategoryData];
    [self creatCollectionView];
    
}
#pragma mark - 创建导航栏
- (void)creatNavBar {
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 64)];
    nameLabel.backgroundColor = [UIColor blackColor];
    nameLabel.text = @"选择分类";
    nameLabel.font = [UIFont systemFontOfSize:20];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:nameLabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 18, 30, 30);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.view addSubview:backButton];
}

#pragma mark - 获取分类数据
- (void)getCategoryData {
    [super postWithURL:@"http://www.imooc.com/api3/labletype" body:@"token=b09b24a0e9720b63b387667ad915eac3&uid=3859703" block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        
        NSArray *array = dic[@"data"];
        for (NSDictionary *dic in array) {
            Glf_ChooseToSortModel *model = [Glf_ChooseToSortModel modelWithDic:dic];
            [_modelArray addObject:model];
        }
        
        [_collectionView reloadData];
    }];
}

#pragma mark - 创建 collectionView
- (void)creatCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.estimatedItemSize =CGSizeMake((WIDITH - 60) / 2, 50);
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_SCREEN, HEIGHT_SCREEN - 64) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[Glf_ChooseToSortCell class] forCellWithReuseIdentifier:@"chooseCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _modelArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Glf_ChooseToSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"chooseCell" forIndexPath:indexPath];
    Glf_ChooseToSortModel *model = _modelArray[indexPath.item];
    cell.model = model;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Glf_ChooseToSortModel *model = _modelArray[indexPath.item];
    
    CGSize sizeForLabel = [model.name boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, __FLT_MAX__) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSFontAttributeName:[UIFont systemFontOfSize:40]} context:nil].size;
    return CGSizeMake(sizeForLabel.width, sizeForLabel.height);
}


@end
