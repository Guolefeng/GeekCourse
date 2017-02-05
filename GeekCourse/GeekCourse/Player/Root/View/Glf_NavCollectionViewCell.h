//
//  Glf_NavCollectionViewCell.h
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Glf_NavCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;

- (void)changeSurfaceWith:(BOOL)YesOrNo;

@end
