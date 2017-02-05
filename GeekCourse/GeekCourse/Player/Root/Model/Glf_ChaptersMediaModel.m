//
//  Glf_ChaptersMediaModel.m
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ChaptersMediaModel.h"

@implementation Glf_ChaptersMediaModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_list = value;
    }
    [super setValue:value forKey:key];
}

@end
