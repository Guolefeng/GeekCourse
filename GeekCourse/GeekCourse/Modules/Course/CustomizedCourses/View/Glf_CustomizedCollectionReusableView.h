//
//  Glf_CustomizedCollectionReusableView.h
//  GeekCourse
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Glf_DataModel;

@interface Glf_CustomizedCollectionReusableView : UICollectionReusableView

@property (nonatomic, retain) Glf_DataModel *model;

@property (nonatomic, copy) NSString *name;

@end
