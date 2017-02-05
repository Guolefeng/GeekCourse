//
//  Glf_ChaptersTableViewCell.h
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Glf_ChaptersMediaModel;

@interface Glf_ChaptersTableViewCell : UITableViewCell

@property (nonatomic, retain) Glf_ChaptersMediaModel *model;

- (void)addMarkImageViewWith:(BOOL)YesOrNo;

@end
