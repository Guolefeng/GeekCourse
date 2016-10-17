//
//  Glf_SearchModel.h
//  GeekCourse
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseModel.h"

@interface Glf_SearchModel : Glf_BaseModel

@property (nonatomic, copy) NSString *id_list;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger numbers;
@property (nonatomic, assign) NSInteger duration;

@end
