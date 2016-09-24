//
//  Glf_CoursesCatagoryCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/24.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CoursesCatagoryCollectionViewCell.h"
#import "Glf_CaregroiesModel.h"
#import "Glf_SkillsModel.h"
#import <UIImageView+WebCache.h>

@interface Glf_CoursesCatagoryCollectionViewCell ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *numberLabel;

@end

@implementation Glf_CoursesCatagoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
        
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_numberLabel];
        
    }
    return self;
}
- (void)setNumber:(NSString *)number {
    if (_number != number) {
        _number = number;
        _numberLabel.text = number;
    }
}

- (void)setSkillsModel:(Glf_SkillsModel *)skillsModel {
    if (_skillsModel != skillsModel) {
        _skillsModel = skillsModel;
        
        NSURL *url = [NSURL URLWithString:skillsModel.pic];
        [_imageView sd_setImageWithURL:url];
        _nameLabel.text = skillsModel.name;
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = CGRectMake(10, 10, 40, 40);
    _nameLabel.frame = CGRectMake(50, 10, self.contentView.frame.size.width / 2, 40);
    _numberLabel.frame = CGRectMake(50 + self.contentView.frame.size.width / 2, 10, 40, 40);
}

@end
