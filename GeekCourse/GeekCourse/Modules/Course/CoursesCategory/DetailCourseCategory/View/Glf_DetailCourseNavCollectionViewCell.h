//
//  Glf_DetailCourseNavCollectionViewCell.h
//  GeekCourse
//
//  Created by dllo on 16/10/8.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Glf_DetailCourseNavCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;

- (void)changeSurface:(BOOL)YesOrNO;
@end
