//
//  Glf_CommentCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CommentCollectionViewCell.h"
#import "Glf_CommentTableViewCell.h"
#import "Glf_BaseViewController.h"
#import "Glf_CommentModel.h"
@interface Glf_CommentCollectionViewCell ()

<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *modelArray;

@end

@implementation Glf_CommentCollectionViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self getCommentData];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, self.contentView.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 200;
    [self.contentView addSubview:_tableView];
    
    [_tableView registerClass:[Glf_CommentTableViewCell class] forCellReuseIdentifier:@"commentCell"];
}


#pragma mark - 获取数据
- (void)getCommentData {
    
    self.modelArray = [NSMutableArray array];
    
    Glf_BaseViewController *baseVC = [[Glf_BaseViewController alloc] init];
    [baseVC postWithURL:@"http://www.imooc.com/api3/coursecommentlist" body:@"cid=671&page=1&token=7663346a454986bbb04485f9a37c172b&uid=4017288" block:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *array = dic[@"data"];
        for (NSDictionary *dic in array) {
            Glf_CommentModel *model = [Glf_CommentModel modelWithDic:dic];
            [_modelArray addObject:model];
        }
        [_tableView reloadData];
    }];
}

#pragma mark - tableView 常规协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Glf_CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    Glf_CommentModel *model = _modelArray[indexPath.row];
    cell.commectModel = model;
    return cell;
}


@end
