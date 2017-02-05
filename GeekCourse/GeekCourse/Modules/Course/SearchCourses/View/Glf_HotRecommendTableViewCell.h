//
//  Glf_HotRecommendTableViewCell.h
//  GeekCourse
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Glf_HotRecommendModel;
@class Glf_SearchModel;

@interface Glf_HotRecommendTableViewCell : UITableViewCell

@property (nonatomic, retain) Glf_HotRecommendModel *model;

@property (nonatomic, retain) Glf_SearchModel *searchModel;

@end
