//
//  Glf_SalaryCollectionViewCell.h
//  GeekCourse
//
//  Created by dllo on 16/9/26.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Glf_SalaryCollectionViewCellDelegate <NSObject>

- (void)pushWebViewWith:(NSInteger)item array:(NSMutableArray *)array;

@end

@interface Glf_SalaryCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, assign) id<Glf_SalaryCollectionViewCellDelegate>delegate;

@end
