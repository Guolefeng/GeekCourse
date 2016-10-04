//
//  Glf_MineCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/3.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_MineCollectionViewCell.h"

@interface Glf_MineCollectionViewCell ()

@property (nonatomic, retain) UIImageView *mineImageView;
@property (nonatomic, retain) UILabel *label;

@end

@implementation Glf_MineCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.mineImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_mineImageView];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
        
    }
    return self;
}

- (void)setImageName:(NSString *)imageName {
    if (_imageName != imageName) {
        _imageName = imageName;
        
        _mineImageView.image = [UIImage imageNamed:imageName];
    }
}

- (void)setLabelName:(NSString *)labelName {
    if (_labelName != labelName) {
        _labelName = labelName;
        
        _label.text = labelName;
    }
}
- (void)layoutSubviews {
    [_mineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView).offset(0);
        make.height.equalTo(@70);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(_mineImageView.mas_bottom).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
