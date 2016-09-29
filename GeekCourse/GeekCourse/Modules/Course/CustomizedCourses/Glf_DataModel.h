//
//  Glf_DataModel.h
//  GeekCourse
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseModel.h"

@interface Glf_DataModel : Glf_BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSMutableArray *coursetype;

@end
