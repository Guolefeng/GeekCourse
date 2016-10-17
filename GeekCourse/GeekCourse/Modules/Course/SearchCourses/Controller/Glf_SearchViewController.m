//
//  Glf_SearchViewController.m
//  GeekCourse
//
//  Created by dllo on 16/10/11.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_SearchViewController.h"
#import "Glf_HotRecommendModel.h"
#import "Glf_HotRecommendTableViewCell.h"
#import "Glf_SearchModel.h"
#import "Glf_SearchDetailViewController.h"

@interface Glf_SearchViewController ()

<
UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate
>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *sectionArray;
@property (nonatomic, retain) NSMutableArray *hotRecommendArray;
@property (nonatomic, retain) NSMutableArray *searchArray;

@property (nonatomic, retain) UISearchBar *searchBar;

@end

@implementation Glf_SearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1.0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setLeftBarButtonItem];
    
    self.sectionArray = [[NSMutableArray alloc] initWithObjects:@"热门推荐", nil];
    self.hotRecommendArray = [NSMutableArray array];
    self.searchArray = [NSMutableArray array];
    
    self.searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.showsCancelButton = YES;
    self.navigationItem.titleView = _searchBar;
    
    [self getHotRecommendData];
    [self tableView];
    
}

#pragma mark - 获取热门推荐数据
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

#pragma mark - UISearchBarDelgate
// called when text starts editing
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [_sectionArray removeAllObjects];
    [_tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (nil != _searchArray) {
        [_searchArray removeAllObjects];
    }
    
    NSString *body = [NSString stringWithFormat:@"keyword=%@&token=6735c1a0a8b1cfc4b8517902742169ff&uid=4017288", _searchBar.text];
    
    [super postWithURL:@"http://www.imooc.com/api3/getcoursekeyword" body:body block:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        NSString *str = dic[@"errorDesc"];
                
        if ([str isEqualToString:@"成功"]) {
            NSArray *arr = dic[@"data"];
            for (NSDictionary *dic in arr) {
                Glf_SearchModel *model = [Glf_SearchModel modelWithDic:dic];
                [_searchArray addObject:model];
            }
            [_tableView reloadData];
        }
    }];
    
}

#pragma mark - tableViewDelegate
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[Glf_HotRecommendTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_sectionArray.count) {
        
        return _hotRecommendArray.count; // 热门推荐数据

    } else {
        
        return _searchArray.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Glf_HotRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (_sectionArray.count) {
       
        Glf_HotRecommendModel *model = _hotRecommendArray[indexPath.row];
        cell.model = model;
        return cell;
        
    } else {
        Glf_SearchModel *model = _searchArray[indexPath.row];
        cell.searchModel = model;
        return cell;
    }
}


#pragma mark - 分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_sectionArray.count > 0) {
        
        NSString *str = _sectionArray[section];
        return str;
    }
    return @"搜索结果";
}

#pragma mark - tableViewCell 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_sectionArray.count) {
        
        Glf_SearchDetailViewController *searchDetailVC = [[Glf_SearchDetailViewController alloc] init];
        Glf_HotRecommendModel *model = _hotRecommendArray[indexPath.row];
        searchDetailVC.keyword = model.name;
        [self.navigationController pushViewController:searchDetailVC animated:YES];
        
    } else {
        Glf_SearchDetailViewController *searchDetailVC = [[Glf_SearchDetailViewController alloc] init];
        Glf_SearchModel *model = _searchArray[indexPath.row];
        searchDetailVC.keyword = model.name;
        [self.navigationController pushViewController:searchDetailVC animated:YES];
    }
}



@end
