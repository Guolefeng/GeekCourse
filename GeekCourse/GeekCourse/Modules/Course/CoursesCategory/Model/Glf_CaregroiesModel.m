//
//  Glf_CaregroiesModel.m
//  GeekCourse
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CaregroiesModel.h"
#import "Glf_SkillsModel.h"

@implementation Glf_CaregroiesModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"skills"]) {
        NSArray *skillsDicArray = value;
        NSMutableArray *skillsArray = [NSMutableArray array];
        
        for (NSDictionary *skillsDic in skillsDicArray) {
            Glf_SkillsModel *skillsModel = [Glf_SkillsModel modelWithDic:skillsDic];
            [skillsArray addObject:skillsModel];
        }
        self.skills = skillsArray;
        return;
    }
    [super setValue:value forKey:key];
}

@end
