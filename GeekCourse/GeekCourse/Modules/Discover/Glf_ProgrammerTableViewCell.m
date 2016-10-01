//
//  Glf_ProgrammerTableViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/1.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ProgrammerTableViewCell.h"
#import "Glf_ProgrammerQuestionModel.h"

@interface Glf_ProgrammerTableViewCell ()

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *labels_typeLabel;
@property (nonatomic, retain) UILabel *lineLabel;
@property (nonatomic, retain) UILabel *answersLabel;
@property (nonatomic, retain) UIImageView *picView;
@property (nonatomic, retain) UILabel *answer_supportsLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;

@end

@implementation Glf_ProgrammerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.numberOfLines = 0;
        [_titleLabel sizeToFit];
        [self.contentView addSubview:_titleLabel];
        
        self.labels_typeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _labels_typeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_labels_typeLabel];
        
        self.lineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _lineLabel.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_lineLabel];
        
        self.answersLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _answersLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_answersLabel];
        
        self.picView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_picView];
        
        self.answer_supportsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _answer_supportsLabel.backgroundColor = [UIColor redColor];
        _answer_supportsLabel.textAlignment = NSTextAlignmentCenter;
        _answer_supportsLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_answer_supportsLabel];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descriptionLabel.numberOfLines = 0;
        [_descriptionLabel sizeToFit];
        [self.contentView addSubview:_descriptionLabel];
    }
    return self;
}

- (void)setModel:(Glf_ProgrammerQuestionModel *)model {
    if (_model != model) {
        _model = model;
        
        _titleLabel.text = model.title;
        _labels_typeLabel.text = [NSString stringWithFormat:@"来自%@", model.labels_type];
        _answersLabel.text = [NSString stringWithFormat:@"%ld回答", model.answers];
        
        NSURL *url = [NSURL URLWithString:model.pic];
        [_picView sd_setImageWithURL:url];
        
        _answer_supportsLabel.text = [NSString stringWithFormat:@"%ld", model.answer_supports];
        _descriptionLabel.text = model.description_list;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(10, 10, WIDTH_SCREEN - 20, 60);
    
    [_labels_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(_titleLabel.mas_bottom).offset(0);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labels_typeLabel.mas_right).offset(10);
        make.width.equalTo(@1);
        make.height.equalTo(@30);
        make.top.equalTo(_titleLabel.mas_bottom).offset(0);
    }];
    
    [_answersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lineLabel.mas_right).offset(10);
        make.top.equalTo(_titleLabel.mas_bottom).offset(0);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(_lineLabel.mas_bottom).offset(15);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    _picView.layer.cornerRadius = _picView.frame.size.width * 0.5;
    _picView.clipsToBounds = YES;
    
    [_answer_supportsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(_picView.mas_bottom).offset(5);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
    }];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_picView.mas_right).offset(10);
        make.top.equalTo(_lineLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}

@end
