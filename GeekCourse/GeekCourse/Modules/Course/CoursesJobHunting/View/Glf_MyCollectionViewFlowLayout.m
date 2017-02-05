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

// 间隔
//static CGFloat const ActiveDistance = 50;
// 放大倍数
//static CGFloat const ScaleFactor = 0.2;

// 设置放大范围
//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    
//    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
//    
//    CGRect visibleRect = (CGRect){self.collectionView.contentOffset, self.collectionView.bounds.size};
//
//    for (UICollectionViewLayoutAttributes *attributes in attrs) {
//        // 如果 cell在屏幕上, 则进行缩放
//        if (CGRectIntersectsRect(attributes.frame, rect)) {
//            
//           // attributes.alpha = 0.5;
//            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x; //item到中心点的距离
//            CGFloat normalizedDistance = distance / ActiveDistance; //距离除以有效距离得到标准化距离
//            
//            //距离小于有效距离才生效
//            // ABS 整数的绝对值
//            if (ABS(distance) < ActiveDistance) {
//                CGFloat zoom = 1 + ScaleFactor * (1 - ABS(normalizedDistance)); //缩放率范围,与标准距离负相关
//                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 0); //x,y轴方向变换
//                attributes.zIndex = 1;
//                attributes.alpha = 1.0;
//                
//            }
//        }
//    }
//    return attrs;
//}

//这个方法简单理解可以当作是用来设置collectionView的偏移量的，计算当前屏幕哪个item中心点距离屏幕中心点近，就将该item拉到中心去。
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat offsetAdjustment = MAXFLOAT;
    ////  |-------[-------]-------|
    ////  |滑动偏移|可视区域 |剩余区域|
    //是整个collectionView在滑动偏移后的当前可见区域的中点
    CGFloat centerX = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    //    CGFloat centerX = self.collectionView.center.x; //这个中点始终是屏幕中点
    
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
// 第一次加载layout、刷新layout, 返回YES.
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


@end
