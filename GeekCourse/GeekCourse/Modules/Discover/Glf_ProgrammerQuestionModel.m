//
//  Glf_ProgrammerQuestionModel.m
//  GeekCourse
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ProgrammerQuestionModel.h"

@implementation Glf_ProgrammerQuestionModel

-(void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_list = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.description_list = value;
    }
    [super setValue:value forKey:key];
}

@end
