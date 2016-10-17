//
//  Glf_TechnologyNewsTableViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/13.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_TechnologyNewsTableViewCell.h"
#import "Glf_TechnologyModel.h"

@interface Glf_TechnologyNewsTableViewCell ()

@property (nonatomic, retain) UIImageView *headerImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *courseTypeLabel;
@property (nonatomic, retain) UILabel *quantityLabel;
@property (nonatomic, retain) UILabel *viewcountLabel;

@end

@implementation Glf_TechnologyNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_headerImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_titleLabel];
        
        self.courseTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _courseTypeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_courseTypeLabel];
        
        self.quantityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _quantityLabel.textAlignment = NSTextAlignmentCenter;
        _quantityLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_quantityLabel];
        
        self.viewcountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _viewcountLabel.textAlignment = NSTextAlignmentCenter;
        _viewcountLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_viewcountLabel];
        
    }
    return self;
}

- (void)setModel:(Glf_TechnologyModel *)model {
    if (_model != model) {
        _model = model;
        
        NSURL *url = [NSURL URLWithString:model.picUrl];
        [_headerImageView sd_setImageWithURL:url];
        
        _titleLabel.text = model.title;
        _courseTypeLabel.text = model.courseType;
        _quantityLabel.text = model.quantity;
        _viewcountLabel.text = [NSString stringWithFormat:@"%@人观看", model.viewcount];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@130);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(_headerImageView.mas_bottom).offset(0);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@25);
    }];
    [_courseTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(_titleLabel.mas_bottom).offset(0);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@20);
    }];
    [_quantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_courseTypeLabel.mas_bottom).offset(0);
        make.right.equalTo(self.contentView.mas_centerX).offset(0);
        make.width.equalTo(@100);
        make.height.equalTo(@15);
    }];
    [_viewcountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).offset(0);
        make.top.equalTo(_courseTypeLabel.mas_bottom).offset(0);
        make.width.equalTo(@100);
        make.height.equalTo(@15);
    }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
