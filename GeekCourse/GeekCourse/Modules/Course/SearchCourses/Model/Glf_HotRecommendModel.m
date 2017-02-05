//
//  Glf_HotRecommendModel.m
//  GeekCourse
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_HotRecommendModel.h"

@implementation Glf_HotRecommendModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_list = value;
    }
    [super setValue:value forKey:key];
}

@end
