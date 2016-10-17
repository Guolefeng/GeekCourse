//
//  Glf_UpLayerCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/26.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_UpLayerCollectionViewCell.h"
#import "Glf_SalaryRaiseModel.h"

@interface Glf_UpLayerCollectionViewCell ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *coursesLabel;
@property (nonatomic, retain) UIImageView *userImageView;
@property (nonatomic, retain) UILabel *study_personsLabel;

@end

@implementation Glf_UpLayerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.numberOfLines = 0;
        [_nameLabel sizeToFit];
        [self.contentView addSubview:_nameLabel];
        
        self.coursesLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_coursesLabel];
        
        self.userImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user"]];
        [self.contentView addSubview:_userImageView];
        
        self.study_personsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_study_personsLabel];
    }
    return self;
}

- (void)setSalaryRaiseModel:(Glf_SalaryRaiseModel *)salaryRaiseModel {
    if (_salaryRaiseModel != salaryRaiseModel) {
        _salaryRaiseModel = salaryRaiseModel;
        
        NSURL *url = [NSURL URLWithString:salaryRaiseModel.path_pic_fmt];
        [_imageView sd_setImageWithURL:url];
        
        _nameLabel.text = salaryRaiseModel.name;
        _coursesLabel.text = [NSString stringWithFormat:@"%ld门课程", salaryRaiseModel.courses];
        _study_personsLabel.text = [NSString stringWithFormat:@"%ld", salaryRaiseModel.study_persons];
    }
}

- (void)layoutSubviews {
    
    _imageView.frame = CGRectMake(10, 10, self.contentView.bounds.size.width - 20, (self.contentView.bounds.size.height - 20) / 2 - 5);

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(_imageView.mas_bottom).offset(10);
        make.width.equalTo(@(_imageView.frame.size.width));
        make.height.equalTo(@(_imageView.frame.size.height / 2));
    }];
    
    [_coursesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(_nameLabel.mas_bottom).offset(0);
        make.width.equalTo(@(self.contentView.frame.size.width / 2 - 10));
        make.height.equalTo(@(30));
    }];
    
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(self.contentView.frame.size.width / 2 + 5);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    [_study_personsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(self.contentView.frame.size.width / 2 + 30);
        make.top.equalTo(_nameLabel.mas_bottom).offset(0);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@30);
    }];
}

@end
