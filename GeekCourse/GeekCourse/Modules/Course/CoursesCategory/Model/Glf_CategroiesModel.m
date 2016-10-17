//
//  Glf_CategroiesModel.m
//  GeekCourse
//
//  Created by dllo on 16/9/25.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CategroiesModel.h"
#import "Glf_SkillModel.h"

@implementation Glf_CategroiesModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"skills"]) {
        NSArray *skillsDicArray = value;
        NSMutableArray *skillsArray = [NSMutableArray array];
        
        for (NSDictionary *skillsDic in skillsDicArray) {
            Glf_SkillModel *skillsModel = [Glf_SkillModel modelWithDic:skillsDic];
            [skillsArray addObject:skillsModel];
        }
        self.skills = skillsArray;
        return;
    }
    [super setValue:value forKey:key];
}

@end
