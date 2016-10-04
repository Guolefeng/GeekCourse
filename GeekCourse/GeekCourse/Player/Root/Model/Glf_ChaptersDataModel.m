//
//  Glf_ChaptersDataModel.m
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ChaptersDataModel.h"
#import "Glf_ChaptersMediaModel.h"

@implementation Glf_ChaptersDataModel


- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"media"]) {
        
        self.media = [NSMutableArray array];
        
        for (NSDictionary *dic in value) {
            Glf_ChaptersMediaModel *model = [Glf_ChaptersMediaModel modelWithDic:dic];
            [_media addObject:model];
        }
    }
}

@end
