//
//  Glf_BaseModel.m
//  GeekCourse
//
//  Created by dllo on 16/9/20.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseModel.h"

@implementation Glf_BaseModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (Glf_BaseModel *)modelWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
