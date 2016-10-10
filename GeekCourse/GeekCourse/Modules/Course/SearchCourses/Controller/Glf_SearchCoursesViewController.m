//
//  Glf_SearchCoursesViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/25.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_SearchCoursesViewController.h"
#import "Glf_HotRecommendModel.h"
#import "Glf_HotRecommendTableViewCell.h"
#import "Glf_SearchModel.h"
#import "Glf_SearchDetailViewController.h"

@interface Glf_SearchCoursesViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UISearchResultsUpdating,
UISearchControllerDelegate
>

@property (nonatomic, retain) UISearchController *searchController;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *sectionArray;
@property (nonatomic, retain) NSMutableArray *hotRecommendArray;
@property (nonatomic, retain) NSMutableArray *searchArray;
@end

@implementation Glf_SearchCoursesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1.0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    [super setLeftBarButtonItem];
    
    self.sectionArray = @[@"搜索记录", @"热门推荐"];
    self.hotRecommendArray = [NSMutableArray array];
    self.searchArray = [NSMutableArray array];
    
    [self getHotRecommendData];
    
    [self creatSearchController];
    
    [self creatTableView];
}

- (void)getHotRecommendData {
    [super postWithURL:@"http://www.imooc.com/api3/searchwordlist" body:nil block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *arr = dic[@"data"];
        for (NSDictionary *dic in arr) {
            Glf_HotRecommendModel *model = [Glf_HotRecommendModel modelWithDic:dic];
            [_hotRecommendArray addObject:model];
        }
        [_tableView reloadData];
    }];
}

#pragma mark - SearchController
- (void)creatSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    // 变暗色
    _searchController.dimsBackgroundDuringPresentation = YES;
    // 搜索时, 背景变模糊
   // _searchController.obscuresBackgroundDuringPresentation = YES;
    // 不隐藏 navigationBar
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.placeholder = @"搜索";
    
    self.navigationItem.titleView = self.searchController.searchBar;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = _searchController.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
    NSString *body = [NSString stringWithFormat:@"keyword=%@&token=6735c1a0a8b1cfc4b8517902742169ff&uid=4017288", predicate];
    
    [super postWithURL:@"http://www.imooc.com/api3/searchwordlist" body:body block:^(id result) {
        NSDictionary *dic = (NSDictionary *)result;
        NSArray *arr = dic[@"data"];
        for (NSDictionary *dic in arr) {
            Glf_SearchModel *model = [Glf_SearchModel modelWithDic:dic];
            [_searchArray addObject:model];
        }
        NSLog(@"1==== %ld", _searchArray.count);
        [_tableView reloadData];
    }];
    
    NSLog(@"2==== %ld", _searchArray.count);
    // 清空原数组
    if (nil != _searchArray) {
        [_searchArray removeAllObjects];
    }
    
}


#pragma mark - TableView
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[Glf_HotRecommendTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchController.active) {
        
        NSLog(@"3--- %ld", _searchArray.count);
        return _searchArray.count; // 搜索结果
        
    } else {
        NSLog(@"gdfdfq");
        if (section == 1) {
            return _hotRecommendArray.count; // 原始数据
        }
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"444");
    Glf_HotRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (_searchController.active) {
        Glf_SearchModel *model = _searchArray[indexPath.row];
        cell.textLabel.text = model.name;
    } else {
        if (indexPath.section == 1) {
            Glf_HotRecommendModel *model = _hotRecommendArray[indexPath.row];
            cell.model = model;
        }
    }
    
    return cell;
}

#pragma mark - 分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_searchController.active) {
        return 0;
    } else {
        return _sectionArray.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *str = _sectionArray[section];
    return str;
}

#pragma mark - tableViewCell 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_searchController.active) {
        NSLog(@"活跃");
    } else {
        if (indexPath.section == 1) {
            Glf_SearchDetailViewController *searchDetailVC = [[Glf_SearchDetailViewController alloc] init];
            Glf_HotRecommendModel *model = _hotRecommendArray[indexPath.row];
            searchDetailVC.keyword = model.name;
            [self.navigationController pushViewController:searchDetailVC animated:YES];
        }
    }
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
