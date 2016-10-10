//
//  Glf_MineCollectionViewCell.h
//  GeekCourse
//
//  Created by dllo on 16/10/3.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Glf_MineCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *labelName;

@property (nonatomic, retain) UILabel *label;
@end
