//
//  Glf_TechnologyNewsViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/13.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_TechnologyNewsViewController.h"
#import "Glf_TechnologyNewsTableViewCell.h"
#import "Glf_TechnologyModel.h"
#import "Glf_VideoPlayerViewController.h"

@interface Glf_TechnologyNewsViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *techModelArray;
@property (nonatomic, assign) NSInteger number;
@end

@implementation Glf_TechnologyNewsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackToTabBarViewController" object:nil];
    [_tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.title = @"科技";
    self.techModelArray = [NSMutableArray array];
    self.number = 0;
    
    [self getTechnologyNewsData];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - 64 - 49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 200;
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getUpData];
        [self.tableView.mj_header endRefreshing];
    }];
    // 上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getDownData];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    [self.view addSubview:_tableView];
    [_tableView registerClass:[Glf_TechnologyNewsTableViewCell class] forCellReuseIdentifier:@"technologyCell"];
}

#pragma mark - 下拉刷新
- (void)getUpData {
    [_techModelArray removeAllObjects];
    [self.tableView reloadData];
    [self getTechnologyNewsData];
}

#pragma mark - 上拉加载
- (void)getDownData {
    _number++;
    [self getTechnologyNewsData];
}

- (void)getTechnologyNewsData {
    NSString *url = [NSString stringWithFormat:@"http://c.open.163.com/mob/classify/newplaylist.do?cursor=%ld&flag=1&id=32&type=5", _number * 20];
    
    [super getWithURL:url block:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *arr = dic[@"data"];
        for (NSDictionary *dic in arr) {
        
            Glf_TechnologyModel *model = [Glf_TechnologyModel modelWithDic:dic];
            [_techModelArray addObject:model];
        }
        [_tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _techModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Glf_TechnologyNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"technologyCell"];
    Glf_TechnologyModel *model = _techModelArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Glf_TechnologyModel *model = _techModelArray[indexPath.row];
    Glf_VideoPlayerViewController *videoPlayerVC = [[Glf_VideoPlayerViewController alloc] init];
    videoPlayerVC.plid = model.plid;
    [self.navigationController pushViewController:videoPlayerVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
