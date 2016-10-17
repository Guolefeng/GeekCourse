//
//  Glf_CourseCategoryCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/25.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CourseCategoryCollectionViewCell.h"
#import "Glf_CategroiesModel.h"
#import "Glf_SkillModel.h"

@interface Glf_CourseCategoryCollectionViewCell ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *numberLabel;

@end

@implementation Glf_CourseCategoryCollectionViewCell

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


- (void)setSkillsModel:(Glf_SkillModel *)skillsModel {
    if (_skillsModel != skillsModel) {
        _skillsModel = skillsModel;
        
        NSURL *url = [NSURL URLWithString:skillsModel.pic];
        [_imageView sd_setImageWithURL:url];
        _nameLabel.text = skillsModel.name;
        _numberLabel.text = [NSString stringWithFormat:@"%ld", skillsModel.numbers];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = CGRectMake(0, 10, 40, 40);

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_right).offset(0);
        make.top.equalTo(self.contentView).offset(10);
        make.width.equalTo(@(self.contentView.frame.size.width / 2));
        make.height.equalTo(@40);
    }];
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(0);
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(0);
        make.height.equalTo(@40);
    }];
}


@end
