//
//  Glf_CustomizedCoursesViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/25.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CustomizedCoursesViewController.h"
#import "Glf_DataModel.h"
#import "Glf_CourseTypeModel.h"
#import "Glf_CustomizedCoursesCollectionViewCell.h"
#import "Glf_CustomizedCollectionReusableView.h"
#import "UIButton+Block.h"

@interface Glf_CustomizedCoursesViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>
@property (nonatomic, retain) NSMutableArray *modelArray;

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, retain) NSMutableArray *nameArray;

@end

@implementation Glf_CustomizedCoursesViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any setup after loading the view.
    self.title = @"定制课程";
    self.modelArray = [NSMutableArray array];
    
    [self creatNavBar];
    [self getCustomizedCoursesData];
    [self creatCollectionView];
    [self creatAllCourseSortView];
}

#pragma mark - 创建导航栏
- (void)creatNavBar {
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 64)];
    nameLabel.backgroundColor = [UIColor blackColor];
    nameLabel.text = @"我的定制";
    nameLabel.font = [UIFont systemFontOfSize:20];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:nameLabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(WIDTH_SCREEN - 70, 18, 60, 30);
    [backButton setTitle:@"确定" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.view addSubview:backButton];
}

#pragma mark - 获取数据
- (void)getCustomizedCoursesData {
    
    [super postWithURL:@"http://www.imooc.com/api3/coursetype" body:@" token=3b38ce4faf579a206f2ef575a5d3dc51&uid=4017288" block:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        self.nameArray = dic[@"data"];
        for (NSDictionary *dic in _nameArray) {
            Glf_DataModel *model = [Glf_DataModel modelWithDic:dic];
            [_modelArray addObject:model];
        }
        
        [_collectionView reloadData];
    }];
}
#pragma mark - 创建 collectionView
- (void)creatCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.estimatedItemSize =CGSizeMake((WIDITH - 60) / 2, 50);
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    flowLayout.headerReferenceSize = CGSizeMake(WIDTH_SCREEN, 30);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_SCREEN, HEIGHT_SCREEN - 64) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
    [self.view addSubview:_collectionView];

    [_collectionView registerClass:[Glf_CustomizedCoursesCollectionViewCell class] forCellWithReuseIdentifier:@"customCell"];
    [_collectionView registerClass:[Glf_CustomizedCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"customHeaderCell"];
}

#pragma mark - 创建全部分类
- (void)creatAllCourseSortView {

    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, -50, 100, 40)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = @"全部分类";
    nameLabel.font = [UIFont systemFontOfSize:22];
    nameLabel.layer.cornerRadius = 10;
    nameLabel.layer.borderWidth = 2.0;
    nameLabel.layer.borderColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.2].CGColor;
    [_collectionView addSubview:nameLabel];
}
#pragma mark - collectionView header
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _modelArray.count;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   Glf_CustomizedCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"customHeaderCell" forIndexPath:indexPath];
//    Glf_DataModel *model = _modelArray[indexPath.section];
//    headerView.model = model;
    
    headerView.name = [_nameArray[indexPath.section] objectForKey:@"name"];
    return headerView;
}

#pragma mark - collectionView 常规协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    Glf_DataModel *dataModel = _modelArray[section];
    return dataModel.coursetype.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Glf_CustomizedCoursesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCell" forIndexPath:indexPath];
    
    Glf_DataModel *dataModel = _modelArray[indexPath.section];
    Glf_CourseTypeModel *model = dataModel.coursetype[indexPath.item];
    cell.model = model;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Glf_DataModel *dataModel = _modelArray[indexPath.section];
    Glf_CourseTypeModel *model = dataModel.coursetype[indexPath.item];
    
    CGSize sizeForLabel = [model.name boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, __FLT_MAX__) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSFontAttributeName:[UIFont systemFontOfSize:35]} context:nil].size;
    return CGSizeMake(sizeForLabel.width, sizeForLabel.height);
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
