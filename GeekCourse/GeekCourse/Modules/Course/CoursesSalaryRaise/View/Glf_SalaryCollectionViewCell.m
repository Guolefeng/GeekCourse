//
//  Glf_SalaryCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/26.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_SalaryCollectionViewCell.h"
#import "Glf_UpLayerCollectionViewCell.h"
#import "Glf_SalaryRaiseModel.h"

@interface Glf_SalaryCollectionViewCell ()

<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, retain) UICollectionView *upLayerCollectionView;

@end

@implementation Glf_SalaryCollectionViewCell

- (void)setArray:(NSMutableArray *)array {
    if (_array != array) {
        _array = array;
    }
    
    [_upLayerCollectionView reloadData];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
#pragma mark - 创建 upLayerConllectionView
    
    UICollectionViewFlowLayout *upLayerFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    upLayerFlowLayout.itemSize = CGSizeMake((self.contentView.frame.size.width - 10 * 3) / 2, (self.contentView.frame.size.height - 64 - 50 - 10 * 3) / 2);
    upLayerFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    
    self.upLayerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, WIDTH_SCREEN, self.contentView.frame.size.height - 50) collectionViewLayout:upLayerFlowLayout];
    _upLayerCollectionView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    _upLayerCollectionView.dataSource = self;
    _upLayerCollectionView.delegate = self;
    
    [self.contentView addSubview:_upLayerCollectionView];
    
    [_upLayerCollectionView registerClass:[Glf_UpLayerCollectionViewCell class] forCellWithReuseIdentifier:@"allCourseCell"];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Glf_UpLayerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"allCourseCell" forIndexPath:indexPath];
    Glf_SalaryRaiseModel *model = _array[indexPath.item];
    cell.salaryRaiseModel = model;
    
    return cell;
}


@end
