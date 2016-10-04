//
//  Glf_CustomizedCoursesCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CustomizedCoursesCollectionViewCell.h"

@interface Glf_CustomizedCoursesCollectionViewCell ()



@end

@implementation Glf_CustomizedCoursesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.2].CGColor;
    
    CGSize sizeForLabel = [_model.name boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, __FLT_MAX__) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSFontAttributeName:[UIFont systemFontOfSize:35]} context:nil].size;
    CGRect labelFrame = _nameLabel.frame;
    labelFrame.size = sizeForLabel;
    
    _nameLabel.frame = labelFrame;
    
    
}

- (void)setModel:(Glf_CourseTypeModel *)model {
    if (_model != model) {
        _model = model;
        
        _nameLabel.text = model.name;
    }
}

@end
