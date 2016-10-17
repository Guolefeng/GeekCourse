//
//  Glf_ChaptersMediaModel.h
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseModel.h"

@interface Glf_ChaptersMediaModel : Glf_BaseModel

@property (nonatomic, copy) NSString *id_list;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *media_url;
@property (nonatomic, copy) NSString *media_down_url;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, copy) NSString *share_url;

@end
