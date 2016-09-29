//
//  Glf_UpCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_UpCollectionViewCell.h"
#import "Glf_JobHuntingModel.h"

@interface Glf_UpCollectionViewCell ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *lineLabel;
@property (nonatomic, retain) UILabel *courseLabel;
@property (nonatomic, retain) UILabel *studyPersonLabel;

@end

@implementation Glf_UpCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initialize];
    }
    return self;
}


- (void)initialize {
    // 意思是图层有双面，是否都显示，设置NO意思背面看不到
    self.layer.doubleSided = NO;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:25];
    [self.contentView addSubview:_nameLabel];
    
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _lineLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_lineLabel];
    
    self.courseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _courseLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_courseLabel];
    
    self.studyPersonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _studyPersonLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_studyPersonLabel];
}

- (void)setModel:(Glf_JobHuntingModel *)model {
    if (_model != model) {
        _model = model;
        
        NSURL *url = [NSURL URLWithString:model.path_pic_fmt];
        [_imageView sd_setImageWithURL:url];
        _nameLabel.text = model.name;
        _courseLabel.text = [NSString stringWithFormat:@"%ld门课程", model.courses];
        _studyPersonLabel.text = [NSString stringWithFormat:@"%ld人学习", model.study_persons];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width / 8;
    
    NSInteger h = self.contentView.frame.size.height;
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.height.equalTo(@(h / 2));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_imageView.mas_bottom).offset(0);
        make.height.equalTo(@((h / 2) / 2.5));
    }];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(50);
        make.right.equalTo(self.contentView).offset(-50);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.height.equalTo(@1);
    }];
    [_courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(_lineLabel.mas_bottom).offset(5);
        make.bottom.equalTo(_studyPersonLabel.mas_top).offset(0);
    }];
    [_studyPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(_courseLabel.mas_bottom).offset(0);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
}

@end
