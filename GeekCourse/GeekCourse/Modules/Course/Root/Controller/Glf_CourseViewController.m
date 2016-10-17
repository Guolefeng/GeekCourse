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
#import "Glf_JobHuntingViewController.h"
#import "Glf_CustomizedCoursesViewController.h"
#import "Glf_BaseModel.h"
#import "Glf_RootPlayerViewController.h"
#import "Glf_SearchViewController.h"
#import "AFNetworking.h"
#import "UIImage+AFNetworking.h"
#import "UIView+Glf_ShowMessage.h"
#import "Glf_SettingViewController.h"

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
    [super viewWillAppear:YES];
    [_tableView.mj_header beginRefreshing];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackToTabBarViewController" object:nil];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    
}
#pragma mark - 课程分类
- (void)creatLeftBarButtonItem {
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sort"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}
#pragma mark - 设置
- (void)creatRightBarButtonItem {
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Setting"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
#pragma mark - 搜索框
- (void)creatSearchFrame {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 10, self.view.frame.size.width - 120, 40)];
    view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    view.layer.cornerRadius = 10;
    view.clipsToBounds = YES;
    self.navigationItem.titleView = view;
    
    UIImageView *searchImageView = [[UIImageView alloc] init];
    searchImageView.image = [UIImage imageNamed:@"search"];
    [view addSubview:searchImageView];
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(10);
        make.top.equalTo(view).offset(5);
        make.bottom.equalTo(view.mas_bottom).offset(-5);
        make.width.equalTo(@30);
    }];
    
    // 搜索
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //searchButton.backgroundColor = [UIColor blueColor];
    [searchButton setTitle:@"搜索相关课程" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    // 设置 searchButton 文字对齐方式
    searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // 这行代码可以让按钮的内容距离左边10个像素.
    searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImageView.mas_right).offset(5);
        make.right.equalTo(view).offset(-5);
        make.top.equalTo(view).offset(5);
        make.bottom.equalTo(view.mas_bottom).offset(-5);
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.arrModel = [NSMutableArray array];

    self.number = 1;
    
    [self networkMonitoring];
    
    [self creatLeftBarButtonItem];
    [self creatRightBarButtonItem];
    [self creatSearchFrame];
    
    [self getTableViewCellData];
    [self creatTableView];
    [self creatHeaderView];
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

#pragma mark - 下拉刷新
- (void)getUpData {
    [_arrModel removeAllObjects];
    
    [self.tableView reloadData];
    [self getTableViewCellData];
}

#pragma mark - 上拉加载
- (void)getDownData {
    _number++;
    [self getTableViewCellData];
}

#pragma mark - TableView 及相关协议
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDITH, HEIGHT - 64) style:0];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 120;
    
    // 上拉加载
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getUpData];
        [self.tableView.mj_header endRefreshing];
    }];
    // 下拉刷新
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选中状态
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Glf_RootPlayerViewController *rootPlayerVC = [[Glf_RootPlayerViewController alloc] init];
    
    Glf_ModelOfCourse *model = _arrModel[indexPath.row];
    rootPlayerVC.cid = model.id_list;
    
    [self.navigationController pushViewController:rootPlayerVC animated:YES];
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
    
    UILabel *customLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 120, WIDTH_SCREEN, 30)];
    customLabel.text = @"极课 - 海量课程随你想看";
    [view addSubview:customLabel];
    
    return view;
}

#pragma mark - 创建 course 的两个方向
- (void)creatThreeItemsOfCareerPathWithView:(UIView *)view  {
    
    UIButton *jobHuntingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [jobHuntingButton setBackgroundImage:[UIImage imageNamed:@"jobHunting"] forState:UIControlStateNormal];
    [jobHuntingButton addTarget:self action:@selector(jobHuntingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:jobHuntingButton];
    [jobHuntingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(30);
        make.top.equalTo(view).offset(10);
        make.width.equalTo(@90);
        make.height.equalTo(@60);
    }];
    UILabel *jobHuntingLable = [[UILabel alloc] init];
    jobHuntingLable.text = @"求职路线";
    jobHuntingLable.textAlignment = NSTextAlignmentCenter;
    [view addSubview:jobHuntingLable];
    [jobHuntingLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(30);
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
        make.centerX.equalTo(view.mas_centerX).offset(0);
        make.top.equalTo(view).offset(10);
        make.width.equalTo(@1);
        make.height.equalTo(@90);
    }];
}

#pragma mark -  course 界面的一些点击事件
- (void)leftBarButtonItemAction:(UIBarButtonItem *)leftBarButton {
    
    Glf_CourseCatagoryViewController *coursesCatagoryVC = [[Glf_CourseCatagoryViewController alloc] init];
    [self.navigationController pushViewController:coursesCatagoryVC animated:YES];
    
}

- (void)rightBarButtonItemAction:(UIBarButtonItem *)rightBarButton {
    Glf_SettingViewController *settingVC = [[Glf_SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)searchButtonAction:(UIButton *)button {
    
    Glf_SearchViewController *searchVC = [[Glf_SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];

}

- (void)addButtonAction:(UIButton *)button {
    Glf_CustomizedCoursesViewController *customizedCoursesVC = [[Glf_CustomizedCoursesViewController alloc] init];
    [self presentViewController:customizedCoursesVC animated:YES completion:nil];
}


- (void)jobHuntingButtonAction:(UIButton *)button {

    Glf_JobHuntingViewController *jobHuntingVC = [[Glf_JobHuntingViewController alloc] init];
    [self.navigationController pushViewController:jobHuntingVC animated:YES];
}
- (void)salaryRaiseButtonAction:(UIButton *)button {
    
    Glf_SalaryRaiseViewController *salaryRaiseVC = [[Glf_SalaryRaiseViewController alloc] init];
    [self.navigationController pushViewController:salaryRaiseVC animated:YES];
}

#pragma mark - 网络监测
- (void)networkMonitoring {
    // 创建网络监听管理者对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                [UIView showMessage:@"未识别的网络"];
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: {
                [UIView showMessage:@"未连接网络"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                [UIView showMessage:@"当前网络环境为: WiFi"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                [UIView showMessage:@"当前网络环境为:2G/3G/4G"];
                break;
            }
            default:
                break;
        }

    }];
    
    // 开始监听
    [manager startMonitoring];
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
