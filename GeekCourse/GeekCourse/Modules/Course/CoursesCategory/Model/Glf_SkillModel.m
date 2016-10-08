//
//  Glf_SkillModel.m
//  GeekCourse
//
//  Created by dllo on 16/9/25.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_SkillModel.h"

@implementation Glf_SkillModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_list = value;
    }
    [super setValue:value forKey:key];
}

@end
