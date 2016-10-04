//
//  Glf_DetailInfoCollectionView.m
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_DetailInfoCollectionView.h"
#import "Glf_MyTableViewCell.h"
#import "Glf_BaseViewController.h"
#import "Glf_ModelOfCourse.h"

@interface Glf_DetailInfoCollectionView ()

<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, retain) NSDictionary *dataDic;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *modelArray;
@end

@implementation Glf_DetailInfoCollectionView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self getInfoData];
    
    [self getRelativeCourseData];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, self.contentView.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 120;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
    [self.contentView addSubview:_tableView];
    
    [_tableView registerClass:[Glf_MyTableViewCell class] forCellReuseIdentifier:@"detailInfoCell"];
    
}
#pragma mark - 获取课程信息
- (void)getInfoData {
    Glf_BaseViewController *baseVC = [[Glf_BaseViewController alloc] init];
    [baseVC postWithURL:@"http://www.imooc.com/api3/getcourseintro" body:@"IMid=1609202236541041&cid=671&token=80c5b82d56c511ebb9f7f54cdde0e6ac&uid=4017288" block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        _dataDic = dic[@"data"];
        
        [_tableView reloadData];
        
        [self creatCourseHeaderInfo];
        [self creatCourseTeacherInfo];
    }];
}
#pragma mark - 创建课程信息
- (void)creatCourseHeaderInfo {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -150, WIDTH_SCREEN, 150)];
    view.backgroundColor = [UIColor whiteColor];
    [_tableView addSubview:view];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, WIDTH_SCREEN, 50)];
    nameLabel.text = _dataDic[@"course_name"];
    nameLabel.font = [UIFont systemFontOfSize:20];
    [view addSubview:nameLabel];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, nameLabel.frame.size.height, WIDTH_SCREEN - 60, view.frame.size.height - nameLabel.frame.size.height)];
    descLabel.text = _dataDic[@"course_des"];
    descLabel.numberOfLines = 0;
    [descLabel sizeToFit];
    [view addSubview:descLabel];
    
}
- (void)creatCourseTeacherInfo {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 150)];
    view.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = view;
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 1, WIDTH_SCREEN - 40, 1)];
    lineLabel.backgroundColor = [UIColor grayColor];
    [view addSubview:lineLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 50, 50)];
    imageView.layer.cornerRadius = imageView.frame.size.width * 0.5;
    imageView.clipsToBounds = YES;
    
    NSArray *teacherArr = _dataDic[@"teacher_list"];
    NSDictionary *dic = [teacherArr firstObject];
    
    NSURL *url = [NSURL URLWithString:dic[@"pic"]];
    [imageView sd_setImageWithURL:url];
    [view addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + 30, 10, 80, imageView.frame.size.height)];
    nameLabel.text = dic[@"nickname"];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:nameLabel];
    
    UILabel *aboutmeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, nameLabel.frame.size.height + 20, WIDTH_SCREEN - 60, 80)
    ];
    aboutmeLabel.text = dic[@"aboutme"];
    aboutmeLabel.numberOfLines = 0;
    [aboutmeLabel sizeToFit];
    [view addSubview:aboutmeLabel];
    
    UILabel *downLineLabel = [[UILabel alloc] init];
    downLineLabel.backgroundColor = [UIColor grayColor];
    [view addSubview:downLineLabel];
    [downLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(20);
        make.right.equalTo(view).offset(-20);
        make.top.equalTo(aboutmeLabel.mas_bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"相关课程";
    label.font = [UIFont systemFontOfSize:20];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(20);
        make.right.equalTo(view).offset(20);
        make.top.equalTo(downLineLabel.mas_bottom).offset(1);
        make.bottom.equalTo(view.mas_bottom).offset(0);
    }];
}

#pragma mark - 获取相关课程
- (void)getRelativeCourseData {
    
    self.modelArray = [NSMutableArray array];
    
    Glf_BaseViewController *baseVC = [[Glf_BaseViewController alloc] init];
    [baseVC postWithURL:@"http://www.imooc.com/api3/getrelevantcourse" body:@"cid=671&token=5b591cc76a6c73324a00c1b60616c117&uid=4017288" block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *arr = dic[@"data"];
        for (NSDictionary *dic in arr) {
            Glf_ModelOfCourse *model = [Glf_ModelOfCourse modelWithDic:dic];
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
    Glf_MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailInfoCell"];
    Glf_ModelOfCourse *model = _modelArray[indexPath.row];
    cell.tableViewCellModel = model;
    return cell;
}


@end
