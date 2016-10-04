//
//  Glf_HandRecordModel.m
//  GeekCourse
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_HandRecordModel.h"

@implementation Glf_HandRecordModel

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.id_list = value;
    }
    if ([key isEqualToString:@"type"]) {
        self.type_list = value;
    }
    
    [super setValue:value forKey:key];
}

@end
