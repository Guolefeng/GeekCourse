//
//  Glf_navUpCollectionViewCell.h
//  GeekCourse
//
//  Created by dllo on 16/9/30.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Glf_navUpCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;
- (void)changeOrNot:(BOOL)YesOrNo;

@end
