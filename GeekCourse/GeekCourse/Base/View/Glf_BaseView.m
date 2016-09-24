//
//  Glf_BaseView.m
//  GeekCourse
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_BaseView.h"

@interface Glf_BaseView ()

<
UIScrollViewDelegate
>

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *currentImageArray;

@end

@implementation Glf_BaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentImageArray = [NSMutableArray array];
        
        // ScrollView
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 200)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        // PageControl
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.pageIndicatorTintColor = [UIColor blackColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
        
    }
    return self;
}
- (void)pageControlValueChanged:(UIPageControl *)pageControl {
    [_scrollView setContentOffset:CGPointMake((pageControl.currentPage + 1) * self.bounds.size.width, 0) animated:YES];
}

- (void)setImageArray:(NSArray *)imageArray {
    if (_imageArray != imageArray) {
        _imageArray = imageArray;
        
        if (_currentImageArray.count > 0) {
            [_currentImageArray removeAllObjects];
            
            // 将之前的 view 移除.
            for (UIView *subView in _scrollView.subviews) {
                if ([subView isKindOfClass:[UIScrollView class]]) {
                    [subView removeFromSuperview];
                }
            }
        }
        [_currentImageArray addObject:[_imageArray lastObject]];
        [_currentImageArray addObjectsFromArray:_imageArray];
        [_currentImageArray addObject:[_imageArray firstObject]];
        
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * _currentImageArray.count, 200);
        
        
        CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_imageArray.count];
        // 确定 pageControl 的尺寸
        CGPoint pageControlOrigin = {(self.bounds.size.width - pageControlSize.width) / 2, self.bounds.size.height - pageControlSize.height - 5};
        CGRect pageControlFrame = {pageControlOrigin, pageControlSize};
        _pageControl.frame = pageControlFrame;
        
        _pageControl.numberOfPages = _imageArray.count;
        _pageControl.currentPage = 0;
        
        for (int i = 0; i < _currentImageArray.count; i++) {
            
            CGPoint imageViewOrigin = {i * self.bounds.size.width, 0};
            CGSize imageViewSize = self.bounds.size;
            CGRect imageViewFrame = {imageViewOrigin, imageViewSize};
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
    
            NSURL *url = [NSURL URLWithString:_currentImageArray[i]];
            [imageView sd_setImageWithURL:url];
            
            [_scrollView addSubview:imageView];
            
            // 设置偏移量
            _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        }
        
        if (_timer) {
            [_timer invalidate];
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }
}

- (void)timerAction:(NSTimer *)timer {
    NSInteger pageNumber = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    if (_imageArray.count == pageNumber) {
        pageNumber = 0;
        _scrollView.contentOffset = CGPointMake(pageNumber * _scrollView.bounds.size.width, 0);
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width * (pageNumber + 1), 0) animated:YES];
    _pageControl.currentPage = pageNumber;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_scrollView]) {
        
        NSInteger pageNumber = scrollView.contentOffset.x / scrollView.bounds.size.width;
        if (0 == pageNumber) {
            pageNumber = _imageArray.count;
        }
        else if (_imageArray.count + 1 == pageNumber) {
            pageNumber = 1;
        }
        
        _pageControl.currentPage = pageNumber - 1;
        
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width * pageNumber, 0);
        
    }
}


@end
