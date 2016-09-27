//
//  Glf_CourseCategoryCollectionViewCell.h
//  GeekCourse
//
//  Created by dllo on 16/9/25.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Glf_SkillModel;

@interface Glf_CourseCategoryCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) Glf_SkillModel *skillsModel;
@property (nonatomic, copy) NSString *number;

@end
