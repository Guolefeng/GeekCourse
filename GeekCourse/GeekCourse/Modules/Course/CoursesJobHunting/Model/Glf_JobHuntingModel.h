//
//  Glf_JobHuntingModel.h
//  GeekCourse
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseModel.h"

@interface Glf_JobHuntingModel : Glf_BaseModel

@property (nonatomic, copy) NSString *id_list;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger study_persons;
@property (nonatomic, assign) NSInteger courses;
@property (nonatomic, copy) NSString *path_pic_fmt;

@end
