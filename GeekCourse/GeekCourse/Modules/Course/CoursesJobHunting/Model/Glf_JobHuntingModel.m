//
//  Glf_JobHuntingModel.m
//  GeekCourse
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_JobHuntingModel.h"

@implementation Glf_JobHuntingModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_list = value;
    }
    [super setValue:value forKey:key];
}

@end
