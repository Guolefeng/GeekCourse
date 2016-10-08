//
//  Glf_MyCollectionViewFlowLayout.m
//  GeekCourse
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_MyCollectionViewFlowLayout.h"

@implementation Glf_MyCollectionViewFlowLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

// ------ 有问题 -------

// 间隔
static CGFloat const ActiveDistance = 50;
// 放大倍数
static CGFloat const ScaleFactor = 0.2;
// 设置放大范围
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect = (CGRect){self.collectionView.contentOffset, self.collectionView.bounds.size};

    for (UICollectionViewLayoutAttributes *attributes in attrs) {
        // 如果 cell在屏幕上, 则进行缩放
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            
           // attributes.alpha = 0.5;
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x; // 距离终点的距离
            CGFloat normalizedDistance = distance / ActiveDistance;
            
            
            if (ABS(distance) < ActiveDistance) {
                CGFloat zoom = 1 + ScaleFactor * (1 - ABS(normalizedDistance)); // 放大渐变
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 0);
                attributes.zIndex = 1;
                attributes.alpha = 1.0;
                
            }
        }
    }

    return attrs;
    
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat offsetAdjustment = MAXFLOAT;
    ////  |-------[-------]-------|
    ////  |滑动偏移|可视区域 |剩余区域|
    //是整个collectionView在滑动偏移后的当前可见区域的中点
    CGFloat centerX = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    //    CGFloat centerX = self.collectionView.center.x; //这个中点始终是屏幕中点
    //所以这里对collectionView的具体尺寸不太理解，输出的是屏幕大小，但实际上宽度肯定超出屏幕的
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes *layoutAttr in array) {
        CGFloat itemCenterX = layoutAttr.center.x;
        
        if (ABS(itemCenterX - centerX) < ABS(offsetAdjustment)) { // 找出最小的offset 也就是最中间的item 偏移量
            offsetAdjustment = itemCenterX - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
