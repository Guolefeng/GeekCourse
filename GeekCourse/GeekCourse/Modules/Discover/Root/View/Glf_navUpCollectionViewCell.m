//
//  Glf_navUpCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/30.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_navUpCollectionViewCell.h"

@interface Glf_navUpCollectionViewCell ()

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UILabel *lineLabel;

@end

@implementation Glf_navUpCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.contentView.frame.size.width, self.contentView.frame.size.height - 20)];
        _label.font = [UIFont systemFontOfSize:20];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
        
        self.lineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_lineLabel];
        
    }
    return self;
}

- (void)changeOrNot:(BOOL)YesOrNo {
    if (YesOrNo) {
        _label.textColor = [UIColor redColor];
        _label.font = [UIFont systemFontOfSize:23];
        _lineLabel.backgroundColor = [UIColor redColor];
    } else {
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:20];
        _lineLabel.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        
        _label.text = title;
    }
    if ([_label.text isEqualToString:@"手记"]) {
        _label.textColor = [UIColor redColor];
        _label.font = [UIFont systemFontOfSize:23];
        _lineLabel.backgroundColor = [UIColor redColor];
    }
    if ([_label.text isEqualToString:@"推荐"]) {
        _label.textColor = [UIColor redColor];
        _label.font = [UIFont systemFontOfSize:23];
        _lineLabel.backgroundColor = [UIColor redColor];
    }
}

- (void)layoutSubviews {
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_label).offset(0);
        make.top.equalTo(_label.mas_bottom).offset(5);
        make.width.equalTo(@50);
        make.height.equalTo(@1);
    }];
}

@end
