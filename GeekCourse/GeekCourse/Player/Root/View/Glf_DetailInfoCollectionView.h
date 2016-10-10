//
//  Glf_DetailInfoCollectionView.h
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Glf_DetailInfoCollectionViewDelegate <NSObject>

- (void)playTheVedioWithCid:(NSString *)cid;

@end

@interface Glf_DetailInfoCollectionView : UICollectionViewCell

@property (nonatomic, assign) id<Glf_DetailInfoCollectionViewDelegate>delegate;
@property (nonatomic, copy) NSString *cid;

@end
