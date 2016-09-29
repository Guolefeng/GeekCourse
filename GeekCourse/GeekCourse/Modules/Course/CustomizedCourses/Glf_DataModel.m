//
//  Glf_DataModel.m
//  GeekCourse
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_DataModel.h"
#import "Glf_CourseTypeModel.h"

@implementation Glf_DataModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"coursetype"]) {
        
        self.coursetype= [NSMutableArray array];
        
        for (NSDictionary *dic in value) {
            Glf_CourseTypeModel *model = [Glf_CourseTypeModel modelWithDic:dic];
            [_coursetype addObject:model];
        }
        
    }
}


@end
