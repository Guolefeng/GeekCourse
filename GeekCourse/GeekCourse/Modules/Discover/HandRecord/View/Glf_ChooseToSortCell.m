//
//  Glf_ChooseToSortCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/2.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ChooseToSortCell.h"
#import "Glf_ChooseToSortModel.h"

@implementation Glf_ChooseToSortCell

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

- (void)setModel:(Glf_ChooseToSortModel *)model {
    if (_model != model) {
        _model = model;
        
        _nameLabel.text = model.name;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.2].CGColor;
    
    CGSize sizeForLabel = [_model.name boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, __FLT_MAX__) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSFontAttributeName:[UIFont systemFontOfSize:40]} context:nil].size;
    CGRect labelFrame = _nameLabel.frame;
    labelFrame.size = sizeForLabel;
    
    _nameLabel.frame = labelFrame;
    
}

@end
