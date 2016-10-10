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

@property (nonatomic, retain) UIView *courseHeaderInfoView;
@property (nonatomic, retain) UIView *courseTeacherInfoView;

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
    
    [_courseHeaderInfoView removeFromSuperview];
    [_courseTeacherInfoView removeFromSuperview];
    [self creatCourseHeaderInfo];
    [self creatCourseTeacherInfo];
    
}

#pragma mark - 获取课程信息
- (void)getInfoData {
    NSString *body = [NSString stringWithFormat:@"IMid=1609202236541041&cid=%@&token=80c5b82d56c511ebb9f7f54cdde0e6ac&uid=4017288", _cid];
    
    Glf_BaseViewController *baseVC = [[Glf_BaseViewController alloc] init];
    [baseVC postWithURL:@"http://www.imooc.com/api3/getcourseintro" body:body block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        _dataDic = dic[@"data"];
        
        [_tableView reloadData];
        

        [self creatCourseHeaderInfo];
        [self creatCourseTeacherInfo];
        
    }];
}

#pragma mark - 创建课程信息
- (void)creatCourseHeaderInfo {
    self.courseHeaderInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, -150, WIDTH_SCREEN, 150)];
    _courseHeaderInfoView.backgroundColor = [UIColor whiteColor];
    [_tableView addSubview:_courseHeaderInfoView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, WIDTH_SCREEN - 60, 50)];
    nameLabel.text = _dataDic[@"course_name"];
    nameLabel.font = [UIFont systemFontOfSize:20];
    [_courseHeaderInfoView addSubview:nameLabel];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, nameLabel.frame.size.height, WIDTH_SCREEN - 60, _courseHeaderInfoView.frame.size.height - nameLabel.frame.size.height)];
    descLabel.text = _dataDic[@"course_des"];
    descLabel.numberOfLines = 0;
    [_courseHeaderInfoView addSubview:descLabel];
    
}
- (void)creatCourseTeacherInfo {
    
    self.courseTeacherInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 200)];
    _courseTeacherInfoView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = _courseTeacherInfoView;
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 1, WIDTH_SCREEN - 40, 1)];
    lineLabel.backgroundColor = [UIColor grayColor];
    [_courseTeacherInfoView addSubview:lineLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 50, 50)];
    imageView.layer.cornerRadius = imageView.frame.size.width * 0.5;
    imageView.clipsToBounds = YES;
    
    NSArray *teacherArr = _dataDic[@"teacher_list"];
    NSDictionary *dic = [teacherArr firstObject];
    
    NSURL *url = [NSURL URLWithString:dic[@"pic"]];
    [imageView sd_setImageWithURL:url];
    [_courseTeacherInfoView addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + 30, 10, 120, imageView.frame.size.height)];
    nameLabel.text = dic[@"nickname"];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [_courseTeacherInfoView addSubview:nameLabel];
    
    UILabel *aboutmeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, nameLabel.frame.size.height + 10, WIDTH_SCREEN - 60, 110)
    ];
    aboutmeLabel.text = dic[@"aboutme"];
    aboutmeLabel.numberOfLines = 0;
    [_courseTeacherInfoView addSubview:aboutmeLabel];
    
    UILabel *downLineLabel = [[UILabel alloc] init];
    downLineLabel.backgroundColor = [UIColor grayColor];
    [_courseTeacherInfoView addSubview:downLineLabel];
    [downLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_courseTeacherInfoView).offset(20);
        make.right.equalTo(_courseTeacherInfoView).offset(-20);
        make.top.equalTo(aboutmeLabel.mas_bottom).offset(2);
        make.height.equalTo(@1);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"相关课程";
    label.font = [UIFont systemFontOfSize:20];
    [_courseTeacherInfoView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_courseTeacherInfoView).offset(20);
        make.right.equalTo(_courseTeacherInfoView).offset(20);
        make.top.equalTo(downLineLabel.mas_bottom).offset(1);
        make.bottom.equalTo(_courseTeacherInfoView.mas_bottom).offset(0);
    }];
}

#pragma mark - 获取相关课程
- (void)getRelativeCourseData {
    
    self.modelArray = [NSMutableArray array];
    NSString *body = [NSString stringWithFormat:@"cid=%@&token=5b591cc76a6c73324a00c1b60616c117&uid=4017288", _cid];
    
    Glf_BaseViewController *baseVC = [[Glf_BaseViewController alloc] init];
    
    [baseVC postWithURL:@"http://www.imooc.com/api3/getrelevantcourse" body:body block:^(id result) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",indexPath.row);
    
    Glf_ModelOfCourse *model = _modelArray[indexPath.row];
    [self.delegate playTheVedioWithCid:model.id_list];
}


@end
