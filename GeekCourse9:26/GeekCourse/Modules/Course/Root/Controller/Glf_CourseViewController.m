//
//  Glf_CourseViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CourseViewController.h"

#import "Glf_ModelOfCourse.h"
#import "Glf_MyTableViewCell.h"
#import "Glf_CourseCatagoryViewController.h"
#import "Glf_HistoryViewController.h"
#import "Glf_SalaryRaiseViewController.h"
#import "Glf_PractiseViewController.h"
#import "Glf_JobHuntingViewController.h"
#import "Glf_CustomizedCoursesViewController.h"
#import "Glf_SearchCoursesViewController.h"
#import "Glf_ScanViewController.h"

@interface Glf_CourseViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *arrModel;

@property (nonatomic, assign) NSInteger number;

@end

@implementation Glf_CourseViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackToTabBarViewController" object:nil];
    
    self.navigationController.navigationBar.translucent = NO;

    [self creatLeftBarButtonItem];
    [self creatRightBarButtonItem];
    [self creatSearchFrameAndScan];

}
#pragma mark - 课程分类
- (void)creatLeftBarButtonItem {
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sort"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}
#pragma mark - 历史记录
- (void)creatRightBarButtonItem {
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"history"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
#pragma mark - 搜索框 扫一扫
- (void)creatSearchFrameAndScan {
    // 搜索
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, self.view.frame.size.width - 120, 30);
    searchButton.backgroundColor = [UIColor cyanColor];
    
    searchButton.layer.cornerRadius = 10;
    [searchButton setTitle:@"🔍 搜索相关课程" forState:UIControlStateNormal];
    // 设置 seatchButton 文字对齐方式
    searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // 这行代码可以让按钮的内容距离左边10个像素.
    searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = searchButton;
    
    // 扫一扫
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanButton setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    [searchButton addSubview:scanButton];
    [searchButton addTarget:self action:@selector(scanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.top.equalTo(searchButton).offset(0);
        make.right.equalTo(searchButton).offset(-5);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.arrModel = [NSMutableArray array];

    self.number = 1;
    
    [self getTableViewCellData];
    [self creatTableView];
    [self creatHeaderView];
}

#pragma mark - 上拉刷新
- (void)getUpData {
    [_arrModel removeAllObjects];
    
    [self.tableView reloadData];
    [self getTableViewCellData];
}

#pragma mark - 下拉加载
- (void)getDownData {
    _number++;
    [self getTableViewCellData];
}

#pragma mark - 创建轮播图
- (void)creatHeaderView {
    // 获取轮播图资料
    NSString *urlString = @"http://www.imooc.com/api3/getadv";
    NSString *bodyString = @"uid=0&marking=banner&token=8301d54bbde33ffc9cce3317a51ecd13";
    [super postWithURL:urlString body:bodyString block:^(id result) {
        
        NSMutableArray *imageNameArray = [NSMutableArray array];
        NSArray *dataArray = [result objectForKey:@"data"];
        for (NSDictionary *dic in dataArray) {
            NSString *imageName = [dic objectForKey:@"pic"];
            [imageNameArray addObject:imageName];
        }
        
        [super creatScrollViewWithImageNameArray:imageNameArray frame:_tableView.tableHeaderView.bounds view:_tableView.tableHeaderView];
        
        [_tableView reloadData];
        
    }];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDITH, 200)];
    headerView.backgroundColor = [UIColor cyanColor];
    self.tableView.tableHeaderView = headerView;
    
}

#pragma mark - TableView 及相关协议
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDITH, HEIGHT - 64) style:0];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 120;
    
    
    // 上啦加载
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getUpData];
        [self.tableView.mj_header endRefreshing];
    }];
    // 下拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getDownData];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    [self.view addSubview:_tableView];
    [_tableView registerClass:[Glf_MyTableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (void)getTableViewCellData {
    NSString *string = @"http://www.imooc.com/api3/courselist_ver2";
    NSURL *url = [NSURL URLWithString:string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    [request setValue:@"mukewang/4.3.2 (iPhone; iOS 7.1.2; Scale/2.00) Paros/3.2.13" forHTTPHeaderField:@"User-Agent"];
    NSString *body = [NSString stringWithFormat:@"cat_type=0&easy_type=0&page=%ld&sort_type=0&token=ee6a63d322163f4b5940328228148a95&uid=3859703", _number];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!error) {
                
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSDictionary *dic = (NSDictionary *)result;
                NSArray *array = dic[@"data"];
                for (NSDictionary *dic in array) {
                    Glf_ModelOfCourse *model = [[Glf_ModelOfCourse alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [_arrModel addObject:model];
                }
                
                [_tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            }
        });
    }];
    
    // 执行任务
    [dataTask resume];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return _arrModel.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Glf_MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (_arrModel.count != 0) {
        cell.tableViewCellModel = _arrModel[indexPath.row];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"第 %ld 行详情.", indexPath.row);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150.f;
}

#pragma mark - 按要求设置 tableView header 形式
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDITH, 150)];
    view.backgroundColor = [UIColor whiteColor];
    
    [self creatThreeItemsOfCareerPathWithView:view];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor blackColor];
    lineLabel.alpha = 0.5;
    [view addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(0);
        make.right.equalTo(view).offset(0);
        make.top.equalTo(view).offset(110);
        make.height.equalTo(@1);
    }];
    
    UILabel *customLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, WIDITH / 4, 30)];
    customLabel.text = @"定制课程";
    customLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:customLabel];
    
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setTitle:@"+ 定制" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-10);
        make.top.equalTo(view).offset(120);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    return view;
}

#pragma mark - 创建 course 的三个方向
- (void)creatThreeItemsOfCareerPathWithView:(UIView *)view  {
    
    UIButton *practiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [practiseButton setBackgroundImage:[UIImage imageNamed:@"practice"] forState:UIControlStateNormal];
    [practiseButton addTarget:self action:@selector(practiseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:practiseButton];
    [practiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(30);
        make.top.equalTo(view).offset(10);
        make.width.equalTo(@90);
        make.height.equalTo(@60);
    }];
    
    UILabel *practiseLable = [[UILabel alloc] init];
    practiseLable.text = @"实战课程";
    practiseLable.textAlignment = NSTextAlignmentCenter;
    [view addSubview:practiseLable];
    [practiseLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(30);
        make.top.equalTo(practiseButton).offset(70);
        make.width.equalTo(@90);
        make.height.equalTo(@20);
    }];
    
    UILabel *firstLabel = [[UILabel alloc] init];
    firstLabel.backgroundColor = [UIColor blackColor];
    firstLabel.alpha = 0.5;
    [view addSubview:firstLabel];
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(practiseButton).offset(110);
        make.top.equalTo(view).offset(10);
        make.width.equalTo(@1);
        make.height.equalTo(@90);
    }];
    
    UIButton *jobHuntingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [jobHuntingButton setBackgroundImage:[UIImage imageNamed:@"jobHunting"] forState:UIControlStateNormal];
    [jobHuntingButton addTarget:self action:@selector(jobHuntingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:jobHuntingButton];
    [jobHuntingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstLabel).offset(21);
        make.top.equalTo(view).offset(10);
        make.width.equalTo(@90);
        make.height.equalTo(@60);
    }];
    UILabel *jobHuntingLable = [[UILabel alloc] init];
    jobHuntingLable.text = @"求职路线";
    jobHuntingLable.textAlignment = NSTextAlignmentCenter;
    [view addSubview:jobHuntingLable];
    [jobHuntingLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstLabel).offset(21);
        make.top.equalTo(jobHuntingButton).offset(70);
        make.width.equalTo(@90);
        make.height.equalTo(@20);
    }];
    
    UIButton *salaryRaiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [salaryRaiseButton setBackgroundImage:[UIImage imageNamed:@"salaryRaise"] forState:UIControlStateNormal];
    [salaryRaiseButton addTarget:self action:@selector(salaryRaiseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:salaryRaiseButton];
    [salaryRaiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-30);
        make.top.equalTo(view).offset(10);
        make.width.equalTo(@90);
        make.height.equalTo(@60);
    }];
    
    UILabel *salaryRaiseLable = [[UILabel alloc] init];
    salaryRaiseLable.text = @"加薪利器";
    salaryRaiseLable.textAlignment = NSTextAlignmentCenter;
    [view addSubview:salaryRaiseLable];
    [salaryRaiseLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-30);
        make.top.equalTo(salaryRaiseButton).offset(70);
        make.width.equalTo(@90);
        make.height.equalTo(@20);
    }];
    
    UILabel *secondLabel = [[UILabel alloc] init];
    secondLabel.backgroundColor = [UIColor blackColor];
    secondLabel.alpha = 0.5;
    [view addSubview:secondLabel];
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(salaryRaiseButton).offset(-110);
        make.top.equalTo(view).offset(10);
        make.width.equalTo(@1);
        make.height.equalTo(@90);
    }];
}

#pragma mark -  course 界面的一些点击事件
- (void)leftBarButtonItemAction:(UIBarButtonItem *)leftBarButton {
    NSLog(@"课程分类");
    
    Glf_CourseCatagoryViewController *coursesCatagoryVC = [[Glf_CourseCatagoryViewController alloc] init];
    [self.navigationController pushViewController:coursesCatagoryVC animated:YES];
    
}

- (void)rightBarButtonItemAction:(UIBarButtonItem *)rightBarButton {
    NSLog(@"历史记录");
    Glf_HistoryViewController *historyVC = [[Glf_HistoryViewController alloc] init];
    [self.navigationController pushViewController:historyVC animated:YES];
}

- (void)searchButtonAction:(UIButton *)button {
    NSLog(@"搜索");
    Glf_SearchCoursesViewController *searchCoursesVC = [[Glf_SearchCoursesViewController alloc] init];
    [self.navigationController pushViewController:searchCoursesVC animated:YES];
}

- (void)scanButtonAction:(UIButton *)button {
    NSLog(@"扫描");
    Glf_ScanViewController *scanVC = [[Glf_ScanViewController alloc] init];
    [self.navigationController pushViewController:scanVC animated:YES];
    
}

- (void)addButtonAction:(UIButton *)button {
    NSLog(@"定制课程");
    Glf_CustomizedCoursesViewController *customizedCoursesVC = [[Glf_CustomizedCoursesViewController alloc] init];
    [self.navigationController pushViewController:customizedCoursesVC animated:YES];
}

- (void)practiseButtonAction:(UIButton *)button {
    NSLog(@"实战课程");
    Glf_PractiseViewController *practiseVC = [[Glf_PractiseViewController alloc] init];
    [self.navigationController pushViewController:practiseVC animated:YES];
}

- (void)jobHuntingButtonAction:(UIButton *)button {
    NSLog(@"求职路线");
    Glf_JobHuntingViewController *jobHuntingVC = [[Glf_JobHuntingViewController alloc] init];
    [self.navigationController pushViewController:jobHuntingVC animated:YES];
}
- (void)salaryRaiseButtonAction:(UIButton *)button {
    NSLog(@"加薪利器");
    
    Glf_SalaryRaiseViewController *salaryRaiseVC = [[Glf_SalaryRaiseViewController alloc] init];
    [self.navigationController pushViewController:salaryRaiseVC animated:YES];
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
