//
//  Glf_ModelOfCourse.m
//  GeekCourse
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ModelOfCourse.h"

@implementation Glf_ModelOfCourse

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_list = value;
    }
    [super setValue:value forKey:key];
}

@end
