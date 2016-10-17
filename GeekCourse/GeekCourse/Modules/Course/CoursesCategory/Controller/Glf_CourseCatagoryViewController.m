//
//  Glf_CourseCatagoryViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/25.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CourseCatagoryViewController.h"

#import "Glf_CourseCategoryCollectionViewCell.h"
#import "Glf_CoursesCollectionReusableView.h"
#import "Glf_CategroiesModel.h"
#import "Glf_SkillModel.h"
#import "Glf_DetailCourseCategory.h"

@interface Glf_CourseCatagoryViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic, retain) UICollectionViewFlowLayout *flowlayout;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *categoriesModelArray;
@property (nonatomic, retain) NSDictionary *dataDic;
@end

@implementation Glf_CourseCatagoryViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [super beLoadingMode];
    // 观察者
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1.0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.title = @"课程分类";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [super setLeftBarButtonItem];
    
    self.categoriesModelArray = [NSMutableArray array];
    
    [self getCoursesData];
    [self creatCollectionView];
    
}
#pragma mark - 获取数据
- (void)getCoursesData {
    [super postWithURL:@"http://www.imooc.com/api3/newcourseskill" body:@"token=0a1b7dc4a13ff17db61048ab50bb5509&uid=0" block:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        self.dataDic = dic[@"data"];
        
        // 创建最上面的 所有课程
        [self creatAllCourseView];
        
        NSArray *categoriesArray = _dataDic[@"categories"];
        
        for (NSDictionary *dic in categoriesArray) {
            Glf_CategroiesModel *model = [[Glf_CategroiesModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_categoriesModelArray addObject:model];
        }
        [_collectionView reloadData];
        
    }];
}

#pragma mark - 创建collectionView
- (void)creatCollectionView {
    self.flowlayout = [[UICollectionViewFlowLayout alloc] init];
    
    _flowlayout.itemSize =CGSizeMake((WIDITH - 60) / 2, 50);
    // 区之间的边距
    _flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    _flowlayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 30);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDITH, HEIGHT - 64) collectionViewLayout:_flowlayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
    
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[Glf_CourseCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [_collectionView registerClass:[Glf_CoursesCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}

#pragma mark - tableView header 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

#pragma mark - 创建全部课程
- (void)creatAllCourseView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, -60, 50, 50)];
    NSURL *url = [NSURL URLWithString:[_dataDic objectForKey:@"pic"]];
    [imageView sd_setImageWithURL:url];
    [_collectionView addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, -60, _flowlayout.itemSize.width / 2, 50)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = [_dataDic objectForKey:@"name"];
    [_collectionView addSubview:nameLabel];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(80 + _flowlayout.itemSize.width / 2, -60, 50, 50)];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.text = [NSString stringWithFormat:@"%@", [_dataDic objectForKey:@"numbers"]];
    [_collectionView addSubview:numberLabel];
}

#pragma mark - collectionView header
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _categoriesModelArray.count;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    Glf_CoursesCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    Glf_CategroiesModel *categoriesModel = _categoriesModelArray[indexPath.section];
    headerView.title = categoriesModel.name;
    
    return headerView;
}

#pragma mark - collectionView 协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    Glf_CategroiesModel *categoriesModel = _categoriesModelArray[section];
    return categoriesModel.skills.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Glf_CourseCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Glf_CategroiesModel *categoriesModel = _categoriesModelArray[indexPath.section];
    Glf_SkillModel *skillsModel = categoriesModel.skills[indexPath.item];
    cell.skillsModel = skillsModel;
    
    return cell;
}

#pragma mark- collectionViewCell 点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Glf_DetailCourseCategory *detailVC = [[Glf_DetailCourseCategory alloc] init];
    
    Glf_CategroiesModel *categoriesModel = _categoriesModelArray[indexPath.section];
    Glf_SkillModel *skillsModel = categoriesModel.skills[indexPath.item];
    
    detailVC.cat_type = skillsModel.id_list;
    detailVC.picUrlString = skillsModel.pic;
    detailVC.name = skillsModel.name;
    
    [self.navigationController pushViewController:detailVC animated:YES];
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
