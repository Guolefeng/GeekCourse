//
//  Glf_CommentTableViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CommentTableViewCell.h"
#import "Glf_CommentModel.h"

@interface Glf_CommentTableViewCell ()

@property (nonatomic, retain) UIImageView *imgView;
@property (nonatomic, retain) UILabel *nicknameLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *descrLabel;
@property (nonatomic, retain) UIImageView *goodView;
@property (nonatomic, retain) UILabel *suportNumLabel;

@end

@implementation Glf_CommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imgView];
        
        self.nicknameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nicknameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nicknameLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_timeLabel];
        
        self.descrLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descrLabel.numberOfLines = 0;
        [_descrLabel sizeToFit];
        _descrLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_descrLabel];
        
        self.goodView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _goodView.image = [UIImage imageNamed:@"good"];
        [self.contentView addSubview:_goodView];
        
        self.suportNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _suportNumLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_suportNumLabel];
        
    }
    return self;
}

- (void)setCommectModel:(Glf_CommentModel *)commectModel {
    if (_commectModel != commectModel) {
        _commectModel = commectModel;
        
        NSURL *url = [NSURL URLWithString:commectModel.img];
        [_imgView sd_setImageWithURL:url];
        
        _nicknameLabel.text = commectModel.nickname;
        _timeLabel.text = commectModel.create_time;
        _descrLabel.text = commectModel.strDescription;
        _suportNumLabel.text = commectModel.support_num;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imgView.frame = CGRectMake(30, 20, 50, 50);
    _imgView.layer.cornerRadius = _imgView.frame.size.width * 0.5;
    _imgView.clipsToBounds = YES;
    [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(0);
        make.top.equalTo(self.contentView).offset(20);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(0);
        make.top.equalTo(_nicknameLabel.mas_bottom).offset(0);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    [_goodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30);
        make.top.equalTo(self.contentView).offset(20);
        make.height.width.equalTo(@30);
    }];
    [_suportNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_goodView.mas_left).offset(0);
        make.top.equalTo(self.contentView).offset(20);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
    [_descrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(0);
        make.left.equalTo(self.contentView).offset(30);
        make.right.equalTo(self.contentView).offset(-30);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
}

@end
