//
//  Glf_ChaptersTableViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ChaptersTableViewCell.h"
#import "Glf_ChaptersMediaModel.h"

@interface Glf_ChaptersTableViewCell ()

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIImageView *playImageView;
@property (nonatomic, retain) UILabel *timeLabel;

@end

@implementation Glf_ChaptersTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_nameLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_timeLabel];
    }
    return self;
}

- (void)addMarkImageViewWith:(BOOL)YesOrNo {

    if (YesOrNo) {
        self.playImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
        _playImageView.image = [UIImage imageNamed:@"play"];
        [self.contentView addSubview:_playImageView];
        _nameLabel.textColor = [UIColor redColor];
        _timeLabel.textColor = [UIColor redColor];

        
    }  else {
        [_playImageView removeFromSuperview];
        _nameLabel.textColor = [UIColor blackColor];
        _timeLabel.textColor = [UIColor blackColor];

    }
}

- (void)layoutSubviews {
   [super layoutSubviews];
   [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.contentView).offset(50);
       make.right.equalTo(_timeLabel.mas_left).offset(0);
       make.top.bottom.equalTo(self.contentView).offset(0);
   }];
   [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self.contentView).offset(-20);
       make.top.bottom.equalTo(self.contentView).offset(0);
       make.width.equalTo(@100);
   }];
    
}

- (void)setModel:(Glf_ChaptersMediaModel *)model {
    if (_model != model) {
        _model = model;
        
        _nameLabel.text = model.name;
        
        NSString *time = [self timeFormatTranform:model.duration];
        
        _timeLabel.text = time;
    }
    
}

// 秒 转换成 时:分:秒
- (NSString *)timeFormatTranform:(NSInteger)totalSeconds {
    
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%2ld:%2ld:%2ld", hours, minutes, seconds];
    
}

@end
