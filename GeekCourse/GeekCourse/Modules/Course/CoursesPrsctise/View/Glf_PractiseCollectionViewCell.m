//
//  Glf_PractiseCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/27.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_PractiseCollectionViewCell.h"
#import "Glf_PractiseModel.h"

@interface Glf_PractiseCollectionViewCell ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *nameLabel;

@end

@implementation Glf_PractiseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.numberOfLines = 0;
        [_nameLabel sizeToFit];
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}

- (void)setModel:(Glf_PractiseModel *)model {
    if (_model != model) {
        _model = model;
        
        NSURL *url = [NSURL URLWithString:model.pic];
        [_imageView sd_setImageWithURL:url];
        
        _nameLabel.text = model.name;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.height.equalTo(@(self.contentView.bounds.size.height * 0.7));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.height.equalTo(@(self.contentView.bounds.size.height * 0.3));
    }];
}
@end
