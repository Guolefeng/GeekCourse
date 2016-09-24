//
//  Glf_CourseViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CourseViewController.h"
#define WIDITH (NSInteger)self.view.bounds.size.width
#define HEIGHT (NSInteger)self.view.bounds.size.height
static NSString *const reuseableCell = @"cell";

#import "Glf_ModelOfCourse.h"
#import "Glf_MyTableViewCell.h"
#import "Glf_CoursesCatagoryViewController.h"
#import "Glf_HistoryViewController.h"

@interface Glf_CourseViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) UIImageView *headerImageView;
@property (nonatomic, retain) NSMutableArray *arrModel;
@property (nonatomic, retain) NSMutableArray *arrScrollImage;
@property(nonatomic, retain) SDCycleScrollView *cycleScrollView;
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
// 课程分类
- (void)creatLeftBarButtonItem {
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sort"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}
// 历史记录
- (void)creatRightBarButtonItem {
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"history"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
// 搜索框 扫一扫
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
    
    self.array = [NSMutableArray array];
    
    self.arrModel = [NSMutableArray array];
    self.arrScrollImage = [NSMutableArray array];
    self.number = 2;
    
    [self getTableViewCellData];
    [self creatTableView];
    [self creatHeaderView];
}

- (void)getUpData {
    [_arrScrollImage removeAllObjects];
    [_arrModel removeAllObjects];
    
    [self.tableView reloadData];
    [self getTableViewCellData];
}

- (void)getDownData {
    _number++;
    [self getTableViewCellData];
}

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
    [_tableView registerClass:[Glf_MyTableViewCell class] forCellReuseIdentifier:reuseableCell];
}

- (void)getTableViewCellData {
    NSString *string = [NSString stringWithFormat:@"http://www.imooc.com/api3/courselist_ver%ld", _number];
    NSURL *url = [NSURL URLWithString:string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    [request setValue:@"mukewang/4.3.2 (iPhone; iOS 7.1.2; Scale/2.00) Paros/3.2.13" forHTTPHeaderField:@"User-Agent"];
    
    request.HTTPBody = [@"cat_type=0&easy_type=0&page=1&sort_type=0&token=ee6a63d322163f4b5940328228148a95&uid=3859703" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!error) {
                
                id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSDictionary *dic = (NSDictionary *)result;
                self.array = dic[@"data"];
                for (NSDictionary *dic in _array) {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return _arrModel.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Glf_MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseableCell];
    
    if (_arrModel.count != 0) {
        cell.tableViewCellModel = _arrModel[indexPath.row];
    }
    
    NSString *str = [NSString stringWithFormat:@"%@",[_array[indexPath.row] objectForKey:@"numbers"]];
    cell.numbers = str;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"第 %ld 行详情.", indexPath.row);
}
// 按要求设置 header 形式
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150.f;
}

- (void)leftBarButtonItemAction:(UIBarButtonItem *)leftBarButton {
    NSLog(@"课程分类");
    
    Glf_CoursesCatagoryViewController *coursesCatagoryVC = [[Glf_CoursesCatagoryViewController alloc] init];
    [self.navigationController pushViewController:coursesCatagoryVC animated:YES];
    
}

- (void)rightBarButtonItemAction:(UIBarButtonItem *)rightBarButton {
    NSLog(@"历史记录");
    Glf_HistoryViewController *historyVC = [[Glf_HistoryViewController alloc] init];
    [self.navigationController pushViewController:historyVC animated:YES];
}

- (void)searchButtonAction:(UIButton *)button {
    NSLog(@"搜索");
}

- (void)scanButtonAction:(UIButton *)button {
    NSLog(@"扫描");
}

- (void)addButtonAction:(UIButton *)button {
    NSLog(@"定制课程");
}

- (void)practiseButtonAction:(UIButton *)button {
    NSLog(@"实战课程");
}

- (void)jobHuntingButtonAction:(UIButton *)button {
    NSLog(@"求职路线");
}
- (void)salaryRaiseButtonAction:(UIButton *)button {
    NSLog(@"加薪利器");
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
