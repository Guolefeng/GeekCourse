//
//  Glf_NavCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_NavCollectionViewCell.h"

@interface Glf_NavCollectionViewCell ()

@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) UILabel *lineLabel;

@end

@implementation Glf_NavCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        self.lineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_lineLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        
        _titleLabel.text = title;
    }
    
    if ([_titleLabel.text isEqualToString:@"章节"]) {
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _lineLabel.backgroundColor = [UIColor redColor];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = self.contentView.bounds;
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.width.equalTo(@50);
        make.height.equalTo(@2);
    }];
}

- (void)changeSurfaceWith:(BOOL)YesOrNo {
    if (YES == YesOrNo) {
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _lineLabel.backgroundColor = [UIColor redColor];
    } else if (NO == YesOrNo) {
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _lineLabel.backgroundColor = [UIColor whiteColor];
    }
}

@end
