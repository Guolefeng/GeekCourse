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
#import "Glf_PlaceholderImageTableViewCell.h"

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
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [self.contentView addSubview:_tableView];
        [_tableView registerClass:[Glf_MyTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [_tableView registerClass:[Glf_PlaceholderImageTableViewCell class] forCellReuseIdentifier:@"placeHolderCell"];
    
        }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_array.count != 0) {
        return _array.count;
    }
    else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_array.count != 0) {
        return 120;
    }
    else {
        return _tableView.frame.size.height;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_array.count != 0) {
        Glf_MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        Glf_ModelOfCourse *model = _array[indexPath.row];
        cell.tableViewCellModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        Glf_PlaceholderImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"placeHolderCell"];
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"TemorarilyNoData"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundView = imgView;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_array.count != 0) {
        
        [_tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self.delegate pushPlayerViewControllerWith:indexPath.row array:_array];
    }
}

@end
