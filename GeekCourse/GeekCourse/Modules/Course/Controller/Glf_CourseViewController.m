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
static NSString *const reuseableItem = @"item";
#import "Glf_MyCollectionViewCell.h"
#import "Glf_ModelOfCourse.h"
#import "Glf_Datas.h"

@interface Glf_CourseViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property (nonatomic, retain) UITableView *courseTableView;

@property (nonatomic, retain) NSArray *practiseImageArray;
@property (nonatomic, retain) NSArray *praciseNameArray;

@end

@implementation Glf_CourseViewController

- (void)viewWillAppear:(BOOL)animated {
    // 导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //self.navigationController.navigationBar.barTintColor = [UIColor redColor];
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
    searchButton.backgroundColor = [UIColor grayColor];
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
    
    [self getPractiseNameAndImageName];
    NSLog(@" %@, %@", _praciseNameArray, _practiseImageArray);
    
    [self creatTableView];
    [self creatHeaderView];
    
    
    
}

- (void)getPractiseNameAndImageName {
    
    _praciseNameArray = @[@"实战课程", @"求职路线", @"加薪利器"];
    _practiseImageArray = @[@"practice", @"jobHunting", @"salaryRaise"];
}

- (void)creatTableView {
    self.courseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDITH, HEIGHT - 64 - 49) style:UITableViewStylePlain];
    _courseTableView.dataSource = self;
    _courseTableView.delegate = self;
    _courseTableView.backgroundColor = [UIColor yellowColor];
    _courseTableView.rowHeight = 120.f;
    [self.view addSubview:_courseTableView];
    [_courseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseableCell];
}

- (void)creatHeaderView {
    // 获取轮播图资料
    NSString *urlString = @"http://www.imooc.com/api3/getadv";
    NSString *bodyString = @"uid=0&marking=banner&token=8301d54bbde33ffc9cce3317a51ecd13";
    [super postWithURL:urlString body:bodyString block:^(id result) {
        NSLog(@"%@", result);
        
        Glf_ModelOfCourse *model = [Glf_ModelOfCourse mj_objectWithKeyValues:(NSDictionary *)result];
        NSLog(@"~~~ %ld", model.dataArray.count);
        
        for (Glf_Datas *data in model.dataArray) {
            NSLog(@"%@", data.pic);
        }
        
    }];
    
    UIScrollView *headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDITH, 200)];
    headerScrollView.backgroundColor = [UIColor cyanColor];
    headerScrollView.showsHorizontalScrollIndicator = YES;
    headerScrollView.pagingEnabled = YES;
    headerScrollView.contentOffset = CGPointMake(WIDITH * 3, 0);
    _courseTableView.tableHeaderView = headerScrollView;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseableCell];
    
    cell.textLabel.text = @"lala";
    
    return cell;
}

// 按要求设置 header 形式
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDITH, 120)];
    view.backgroundColor = [UIColor grayColor];
    
    [self creatThreeItemsOfCareerPathWithView:view];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor blackColor];
    lineLabel.alpha = 0.5;
    [view addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(0);
        make.right.equalTo(view).offset(0);
        make.top.equalTo(view).offset(90);
        make.height.equalTo(@1);
    }];
    
    UILabel *customLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, WIDITH / 4, 30)];
    customLabel.backgroundColor = [UIColor whiteColor];
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
        make.top.equalTo(view).offset(90);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    return view;
}
// 设置 tableView 分区头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"section %ld", section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 120.f;
}

- (void)creatThreeItemsOfCareerPathWithView:(UIView *)view  {
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.itemSize = CGSizeMake(WIDITH / 4, 90);
    // 设置 collectionView 每个 section 的边距
    collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 25, 0, 25);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:view.bounds collectionViewLayout:collectionViewFlowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [view addSubview:collectionView];
    
    [collectionView registerClass:[Glf_MyCollectionViewCell class] forCellWithReuseIdentifier:reuseableItem];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Glf_MyCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:reuseableItem forIndexPath:indexPath];
    item.modelOfCourse.practiseImageName = _practiseImageArray[indexPath.row];
    item.modelOfCourse.practiseName = _praciseNameArray[indexPath.row];
    return item;

}

- (void)leftBarButtonItemAction:(UIBarButtonItem *)leftBarButton {
    NSLog(@"课程分类");
}

- (void)rightBarButtonItemAction:(UIBarButtonItem *)rightBarButton {
    NSLog(@"历史记录");
}

- (void)searchButtonAction:(UIButton *)button {
    NSLog(@"搜索");
}

- (void)scanButtonAction:(UIButton *)button {
    NSLog(@"扫描");
}

- (void)addButtonAction:(UIButton *)buttton {
    NSLog(@"定制课程");
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
