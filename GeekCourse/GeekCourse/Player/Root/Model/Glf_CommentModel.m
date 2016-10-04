//
//  Glf_CommentModel.m
//  GeekCourse
//
//  Created by dllo on 16/9/30.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CommentModel.h"

@implementation Glf_CommentModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (Glf_CommentModel *)modelWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

//+ (JSONKeyMapper *)keyMapper {
//    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"descripation" : @"list_description"}];
//}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.strDescription = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.str_id = value;
    }
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}



@end
