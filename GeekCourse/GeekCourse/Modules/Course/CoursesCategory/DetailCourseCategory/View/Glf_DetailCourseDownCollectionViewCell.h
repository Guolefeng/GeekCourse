//
//  Glf_DetailCourseDownCollectionViewCell.h
//  GeekCourse
//
//  Created by dllo on 16/10/8.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Glf_DetailCourseDownCollectionViewCellDelegate <NSObject>

- (void)pushPlayerViewControllerWith:(NSInteger)row array:(NSMutableArray *)array;

@end

@interface Glf_DetailCourseDownCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) NSMutableArray *array;

@property (nonatomic, assign) id<Glf_DetailCourseDownCollectionViewCellDelegate>delegate;

@end
