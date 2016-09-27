//
//  Glf_SalaryRaiseModel.h
//  GeekCourse
//
//  Created by dllo on 16/9/25.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseModel.h"

@interface Glf_SalaryRaiseModel : Glf_BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path_pic_fmt;
@property (nonatomic, assign) NSInteger study_persons;
@property (nonatomic, assign) NSInteger courses;

@end
