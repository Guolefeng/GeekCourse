//
//  Glf_CoursesCatagoryCollectionViewCell.h
//  GeekCourse
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Glf_SkillsModel;

@interface Glf_CoursesCatagoryCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) Glf_SkillsModel *skillsModel;
@property (nonatomic, copy) NSString *number;

@end
