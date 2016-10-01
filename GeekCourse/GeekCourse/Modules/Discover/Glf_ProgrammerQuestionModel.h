//
//  Glf_ProgrammerQuestionModel.h
//  GeekCourse
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseModel.h"

@interface Glf_ProgrammerQuestionModel : Glf_BaseModel

@property (nonatomic, copy) NSString *id_list;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger top_reply;
@property (nonatomic, copy) NSString *description_list;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger answer_supports;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger answers;
@property (nonatomic, copy) NSString *labels_type;

@end
