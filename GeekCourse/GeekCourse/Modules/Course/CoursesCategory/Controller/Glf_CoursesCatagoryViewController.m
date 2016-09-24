//
//  Glf_CoursesCatagoryViewController.m
//  GeekCourse
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CoursesCatagoryViewController.h"
#import "Glf_CoursesCatagoryCollectionViewCell.h"
#import "Glf_CourseCollectionReusableView.h"
#import "Glf_CaregroiesModel.h"
#import "Glf_SkillsModel.h"

#define WIDITH (NSInteger)self.view.bounds.size.width
#define HEIGHT (NSInteger)self.view.bounds.size.height

@interface Glf_CoursesCatagoryViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic, retain) UICollectionViewFlowLayout *flowlayout;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *categoriesModelArray;
@property (nonatomic, retain) NSDictionary *dataDic;
@end

@implementation Glf_CoursesCatagoryViewController

- (void)viewWillAppear:(BOOL)animated {
    
    // 观察者
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WhenPushPage" object:nil];
    
    self.view.backgroundColor = [UIColor cyanColor];
    self.title = @"课程分类";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.categoriesModelArray = [NSMutableArray array];
    
    [self getCoursesData];
    [self creatCollectionView];
    
}

- (void)getCoursesData {
    [super postWithURL:@"http://www.imooc.com/api3/newcourseskill" body:@"token=0a1b7dc4a13ff17db61048ab50bb5509&uid=0" block:^(id result) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        self.dataDic = dic[@"data"];
        
        // 创建最上面的 所有课程
        [self creatAllCourseView];
        
        NSArray *categoriesArray = _dataDic[@"categories"];
        
        for (NSDictionary *dic in categoriesArray) {
            Glf_CaregroiesModel *model = [[Glf_CaregroiesModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_categoriesModelArray addObject:model];
        }
        
        [_collectionView reloadData];
        
    }];
}

- (void)creatCollectionView {
    self.flowlayout = [[UICollectionViewFlowLayout alloc] init];
    
    _flowlayout.itemSize =CGSizeMake((WIDITH - 60) / 2, 50);
    // 区之间的边距
    _flowlayout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
    
    _flowlayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 30);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDITH, HEIGHT - 64) collectionViewLayout:_flowlayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
    
    
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[Glf_CoursesCatagoryCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [_collectionView registerClass:[Glf_CourseCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _categoriesModelArray.count;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    Glf_CourseCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    Glf_CaregroiesModel *categoriesModel = _categoriesModelArray[indexPath.section];
    headerView.title = categoriesModel.name;
    
    return headerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    Glf_CaregroiesModel *categoriesModel = _categoriesModelArray[section];
    return categoriesModel.skills.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Glf_CoursesCatagoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Glf_CaregroiesModel *caregoriesModel = _categoriesModelArray[indexPath.section];
    Glf_SkillsModel *skillsModel = caregoriesModel.skills[indexPath.item];
    cell.skillsModel = skillsModel;
    cell.number = [NSString stringWithFormat:@"%@", skillsModel.numbers];
    return cell;
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
