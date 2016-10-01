//
//  Glf_deepCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_deepCollectionViewCell.h"
#import "Glf_HandRecordTableViewCell.h"

@interface Glf_deepCollectionViewCell ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation Glf_deepCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self creatTableView];
    }
    return self;
}

#pragma mark - 创建 tableView
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 200;
    [self.contentView addSubview:_tableView];
    
    [_tableView registerClass:[Glf_HandRecordTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - tableView 协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Glf_HandRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Glf_HandRecordModel *model = _array[indexPath.row];
    cell.model = model;
    return cell;
}

@end
