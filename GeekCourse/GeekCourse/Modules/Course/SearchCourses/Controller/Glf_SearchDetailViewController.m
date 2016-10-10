//
//  Glf_SearchDetailViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_SearchDetailViewController.h"
#import "Glf_ModelOfCourse.h"
#import "Glf_MyTableViewCell.h"
#import "Glf_RootPlayerViewController.h"

@interface Glf_SearchDetailViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *modelArray;

@end

@implementation Glf_SearchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = _keyword;
    [super setLeftBarButtonItem];
    
    self.modelArray = [NSMutableArray array];
    
    [self getSearchDetailData];
    
    [self creatTableView];
}
- (void)getSearchDetailData {
    
    NSString *body = [NSString stringWithFormat:@"keyword=%@&page=1&token=8dded8e1a2c78425715aa040f3ccdbd6&uid=4017288", _keyword];
    
    [super postWithURL:@"http://www.imooc.com/api3/courselist_ver2" body:body block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *arr = dic[@"data"];
        for (NSDictionary *dic in arr) {
            Glf_ModelOfCourse *model = [Glf_ModelOfCourse modelWithDic:dic];
            [_modelArray addObject:model];
        }
        [_tableView reloadData];
    }];
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 120;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[Glf_MyTableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Glf_MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Glf_ModelOfCourse *model = _modelArray[indexPath.row];
    cell.tableViewCellModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Glf_RootPlayerViewController *rootPlayerVC = [[Glf_RootPlayerViewController alloc] init];
    
    Glf_ModelOfCourse *model = _modelArray[indexPath.row];
    rootPlayerVC.cid = model.id_list;
    
    [self.navigationController pushViewController:rootPlayerVC animated:YES];
    
}

@end
