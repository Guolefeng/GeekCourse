//
//  Glf_ModelOfCourse.h
//  GeekCourse
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseModel.h"

@interface Glf_ModelOfCourse : Glf_BaseModel

@property (nonatomic, retain) NSMutableArray *dataArray;
// 课程 cell
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, assign) NSInteger numbers;

@end
