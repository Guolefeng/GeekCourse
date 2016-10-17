//
//  Glf_videoListModel.h
//  GeekCourse
//
//  Created by dllo on 16/10/14.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseModel.h"

@interface Glf_videoListModel : Glf_BaseModel

@property (nonatomic, copy) NSString *plid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger *mLength;
@property (nonatomic, copy) NSString *mp4SdUrl;

@end
