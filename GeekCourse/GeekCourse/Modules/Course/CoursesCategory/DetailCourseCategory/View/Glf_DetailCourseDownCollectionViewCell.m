//
//  Glf_DetailCourseDownCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/8.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_DetailCourseDownCollectionViewCell.h"
#import "Glf_MyTableViewCell.h"
#import "Glf_ModelOfCourse.h"

@interface Glf_DetailCourseDownCollectionViewCell ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation Glf_DetailCourseDownCollectionViewCell

- (void)setArray:(NSMutableArray *)array {
    if (_array != array) {
        _array = array;
    }
    [_tableView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
        _tableView.rowHeight = 120;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.contentView addSubview:_tableView];
        [_tableView registerClass:[Glf_MyTableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Glf_MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Glf_ModelOfCourse *model = _array[indexPath.row];
    cell.tableViewCellModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate pushPlayerViewController];
}

@end
