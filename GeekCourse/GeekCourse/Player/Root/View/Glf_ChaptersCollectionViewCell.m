//
//  Glf_ChaptersCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ChaptersCollectionViewCell.h"
#import "Glf_ChaptersTableViewCell.h"
#import "Glf_ChaptersDataModel.h"
#import "Glf_BaseViewController.h"

@interface Glf_ChaptersCollectionViewCell ()

<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) NSInteger *selectedItem;
@property (nonatomic, retain) NSMutableArray *arr;
@end

@implementation Glf_ChaptersCollectionViewCell

#pragma mark - 获取视屏数据
- (void)getVideoChaptersData {
    self.dataMutableArray = [NSMutableArray array];
    
    NSString *url = @"http://www.imooc.com/api3/getcpinfo_ver2";
    NSString *body = @"IMid=16092022365416&cid=671&token=115f77db60b36ab780fd914850b38b8e&uid=4017288";
    
    Glf_BaseViewController *baseVC = [[Glf_BaseViewController alloc] init];
    
    [baseVC postWithURL:url body:body block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        self.arr = dic[@"data"];
        
        for (NSDictionary *dic in _arr) {
            Glf_ChaptersDataModel *model = [Glf_ChaptersDataModel modelWithDic:dic];
            [_dataMutableArray addObject:model];
        }
        [_tableView reloadData];

    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self getVideoChaptersData];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, self.contentView.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.contentView addSubview:_tableView];
    
    [_tableView registerClass:[Glf_ChaptersTableViewCell class] forCellReuseIdentifier:@"chaptersCell"];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}


#pragma mark - 设置分区头
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataMutableArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *dic = [_arr[section] objectForKey:@"chapter"];
    NSString *name = [dic objectForKey:@"name"];
    return [NSString stringWithFormat:@"第%ld章 %@", section + 1, name];
}

#pragma mark - tableView 常规协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Glf_ChaptersDataModel *model = _dataMutableArray[section];
    return model.media.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Glf_ChaptersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chaptersCell"];
    
    Glf_ChaptersDataModel *model = _dataMutableArray[indexPath.section];
    Glf_ChaptersMediaModel *mediaModel = model.media[indexPath.row];
    cell.model = mediaModel;
    
    return cell;
}

@end
