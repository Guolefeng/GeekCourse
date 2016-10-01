//
//  Glf_HandRecordCollectionViewCell.h
//  GeekCourse
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Glf_HandRecordCollectionViewCellDelegate <NSObject>

- (void)pushHandRecordViewController;

@end

@interface Glf_HandRecordCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) id<Glf_HandRecordCollectionViewCellDelegate>delegate;

@end
