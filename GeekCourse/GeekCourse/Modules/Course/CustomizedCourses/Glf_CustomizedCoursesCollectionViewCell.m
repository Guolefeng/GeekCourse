//
//  Glf_CustomizedCoursesCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CustomizedCoursesCollectionViewCell.h"
#import "UILabel+Glf_SizeToFit_W_H.h"

@interface Glf_CustomizedCoursesCollectionViewCell ()

@property (nonatomic, retain) UILabel *nameLabel;

@end

@implementation Glf_CustomizedCoursesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 20;
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _nameLabel.frame = self.contentView.bounds;
    
//    _nameLabel.font = [UIFont systemFontOfSize:20];
//    CGFloat width = [UILabel getWidthWithTitle:_nameLabel.text font:_nameLabel.font];
//    _nameLabel.frame = CGRectMake(0, 0, width, self.contentView.frame.size.height);
}

- (void)setModel:(Glf_CourseTypeModel *)model {
    if (_model != model) {
        _model = model;
        
        _nameLabel.text = model.name;
    }
}

@end
