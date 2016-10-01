//
//  Glf_ProgrammerDeepCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ProgrammerDeepCollectionViewCell.h"
#import "Glf_ProgrammerTableViewCell.h"
#import "Glf_ProgrammerQuestionModel.h"

@interface Glf_ProgrammerDeepCollectionViewCell ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation Glf_ProgrammerDeepCollectionViewCell

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
    
    [_tableView registerClass:[Glf_ProgrammerTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - tableView 协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Glf_ProgrammerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Glf_ProgrammerQuestionModel *model = _array[indexPath.row];
    cell.model = model;
    return cell;
}


@end
