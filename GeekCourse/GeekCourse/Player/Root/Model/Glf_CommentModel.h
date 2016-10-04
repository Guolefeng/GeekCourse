//
//  Glf_CommentModel.h
//  GeekCourse
//
//  Created by dllo on 16/9/30.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Glf_CommentModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *str_id;
@property (nonatomic, copy) NSString<Optional> *uid;
@property (nonatomic, copy) NSString<Optional> *nickname;
@property (nonatomic, copy) NSString<Optional> *img;
@property (nonatomic, copy) NSString<Optional> *strDescription;
@property (nonatomic, copy) NSString<Optional> *create_time;
@property (nonatomic, copy) NSString<Optional> *support_num;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
@end
