//
//  Glf_SalaryRaiseHeaderCollectionViewCell.h
//  GeekCourse
//
//  Created by dllo on 16/9/26.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Glf_SalaryRaiseHeaderCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;

@property (nonatomic, retain) UILabel *label;

- (void)changeSurfaceWith:(BOOL)YesOrNo;

@end
