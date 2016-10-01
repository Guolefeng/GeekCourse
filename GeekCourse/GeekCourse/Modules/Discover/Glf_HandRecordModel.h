//
//  Glf_HandRecordModel.h
//  GeekCourse
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseModel.h"

@interface Glf_HandRecordModel : Glf_BaseModel

@property (nonatomic, copy) NSString *id_list;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger view;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *type_list;
@property (nonatomic, assign) NSInteger push;
@property (nonatomic, assign) NSInteger comment;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *img;

@end
