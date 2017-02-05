//
//  Glf_DetailCourseNavCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/8.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_DetailCourseNavCollectionViewCell.h"

@interface Glf_DetailCourseNavCollectionViewCell ()

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UILabel *lineLabel;
@end

@implementation Glf_DetailCourseNavCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.textColor = [UIColor grayColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
        
        self.lineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_lineLabel];
        
    }
    return self;
}

- (void)changeSurface:(BOOL)YesOrNO {
    
    if (YesOrNO) {
        _label.textColor = [UIColor blackColor];
        _lineLabel.backgroundColor = [UIColor blackColor];
    } else {
        _label.textColor = [UIColor grayColor];
        _lineLabel.backgroundColor = [UIColor whiteColor];
    }
    
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        
        _label.text = title;
    }
    if ([title isEqualToString:@"全部"]) {
        _label.textColor = [UIColor blackColor];
        _lineLabel.backgroundColor = [UIColor blackColor];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _label.frame = self.bounds;
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
        make.top.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(@50);
        make.height.equalTo(@2);
    }];
}

@end
