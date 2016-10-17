//
//  Glf_ChaptersCollectionViewCell.h
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Glf_ChaptersCollectionViewCellDelegate <NSObject>

- (void)changeVideoWith:(NSString *)media_url;

@end

@interface Glf_ChaptersCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) id<Glf_ChaptersCollectionViewCellDelegate>delegate;
@property (nonatomic, retain) NSMutableArray *dataMutableArray;
@property (nonatomic, retain) NSString *cid;

@end
