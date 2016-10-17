//
//  Glf_TechnologyModel.h
//  GeekCourse
//
//  Created by dllo on 16/10/13.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseModel.h"

@interface Glf_TechnologyModel : Glf_BaseModel

@property (nonatomic, copy) NSString *plid;

@property (nonatomic, copy) NSString *courseType;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSNumber *viewcount;

@end
