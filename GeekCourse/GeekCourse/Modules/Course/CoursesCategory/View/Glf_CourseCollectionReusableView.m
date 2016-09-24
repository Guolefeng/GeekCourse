//
//  Glf_CourseCollectionReusableView.m
//  GeekCourse
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CourseCollectionReusableView.h"

@interface Glf_CourseCollectionReusableView ()

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UILabel *lineLabel;
@end

@implementation Glf_CourseCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.backgroundColor = [UIColor whiteColor];
        [self addSubview:_label];
        
        self.lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = [UIColor blackColor];
        _lineLabel.alpha = 0.5;
        [_label addSubview:_lineLabel];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        self.label.text = title;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = CGRectMake(20, 0, self.bounds.size.width - 20, self.bounds.size.height);
    self.lineLabel.frame = CGRectMake(0, 1, self.bounds.size.width, 1);
}

@end
