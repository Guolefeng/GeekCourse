//
//  Glf_ChooseToSortModel.m
//  GeekCourse
//
//  Created by dllo on 16/10/2.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ChooseToSortModel.h"

@implementation Glf_ChooseToSortModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_list = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.description_list = value;
    }
    if ([key isEqualToString:@"type"]) {
        self.type_list = value;
    }
    [super setValue:value forKey:key];
}

@end
