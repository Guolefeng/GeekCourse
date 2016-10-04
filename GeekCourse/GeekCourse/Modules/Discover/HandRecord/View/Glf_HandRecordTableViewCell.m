//
//  Glf_HandRecordTableViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_HandRecordTableViewCell.h"
#import "Glf_HandRecordModel.h"

@interface Glf_HandRecordTableViewCell ()

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *viewLabel;
@property (nonatomic, retain) UILabel *pushLabel;
@property (nonatomic, retain) UILabel *commentLabel;
@property (nonatomic, retain) UILabel *descLabel;
@property (nonatomic, retain) UIImageView *imgView;

@end

@implementation Glf_HandRecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.numberOfLines = 0;
        [_titleLabel sizeToFit];
        [self.contentView addSubview:_titleLabel];
        
        self.viewLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _viewLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_viewLabel];
        
        
        self.pushLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _pushLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_pushLabel];
        
        self.commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_commentLabel];
        
        self.descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLabel.numberOfLines = 0;
        [_descLabel sizeToFit];
        [self.contentView addSubview:_descLabel];
        
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imgView];
    }
    return self;
}

- (void)setModel:(Glf_HandRecordModel *)model {
    if (_model != model) {
        _model = model;
        
        _titleLabel.text = model.title;
        _viewLabel.text = [NSString stringWithFormat:@"%ld浏览", model.view];
        _pushLabel.text = [NSString stringWithFormat:@"%ld推荐", model.push];
        _commentLabel.text = [NSString stringWithFormat:@"%ld评论", model.comment];
        _descLabel.text = model.desc;
        
        NSURL *url = [NSURL URLWithString:model.img];
        [_imgView sd_setImageWithURL:url];
        
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(20, 10, WIDTH_SCREEN - 40, 60);
    
    [_viewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(_titleLabel.mas_bottom).offset(0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    [_pushLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_viewLabel.mas_right).offset(20);
        make.top.equalTo(_titleLabel.mas_bottom).offset(0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pushLabel.mas_right).offset(20);
        make.top.equalTo(_titleLabel.mas_bottom).offset(0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    if ([_model.img isEqualToString:@""]) {
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(_viewLabel.mas_bottom).offset(0);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    } else {
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(_commentLabel.mas_bottom).offset(0);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.width.equalTo(@80);
        }];
        
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(_imgView.mas_left).offset(-20);
            make.top.equalTo(_viewLabel.mas_bottom).offset(0);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }
    
}



@end
