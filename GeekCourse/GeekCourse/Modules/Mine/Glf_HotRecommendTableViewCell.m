//
//  Glf_HotRecommendTableViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_HotRecommendTableViewCell.h"
#import "Glf_HotRecommendModel.h"

@interface Glf_HotRecommendTableViewCell ()

@property (nonatomic, retain) UILabel *titleLabel;

@end

@implementation Glf_HotRecommendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setModel:(Glf_HotRecommendModel *)model {
    if (_model != model) {
        _model = model;
        
        _titleLabel.text = model.name;
    }
}

- (void)layoutSubviews {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self).offset(0);
        make.right.equalTo(self).offset(-30);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
}

@end
