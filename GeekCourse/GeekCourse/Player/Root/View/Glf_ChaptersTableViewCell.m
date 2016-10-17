//
//  Glf_ChaptersTableViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/29.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ChaptersTableViewCell.h"
#import "Glf_ChaptersMediaModel.h"
#import <AVFoundation/AVFoundation.h>

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
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_timeLabel];
        
        self.playImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 13, 15, 15)];
        
    }
    return self;
}

- (void)addMarkImageViewWith:(BOOL)YesOrNo {

    if (YesOrNo) {
        _playImageView.image = [UIImage imageNamed:@"play"];
        [self.contentView addSubview:_playImageView];
        
        _nameLabel.textColor = [UIColor redColor];
        _timeLabel.textColor = [UIColor redColor];
        
    } else {
        [_playImageView removeFromSuperview];
        
        _nameLabel.textColor = [UIColor blackColor];
        _timeLabel.textColor = [UIColor blackColor];

    }
}

- (void)layoutSubviews {
   [super layoutSubviews];
   [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.contentView).offset(20);
       make.right.equalTo(_timeLabel.mas_left).offset(0);
       make.top.bottom.equalTo(self.contentView).offset(0);
   }];

   [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self.contentView).offset(-10);
       make.top.bottom.equalTo(self.contentView).offset(0);
       make.width.equalTo(@80);
   }];
    
}

- (void)setModel:(Glf_ChaptersMediaModel *)model {
    if (_model != model) {
        _model = model;
        
        _nameLabel.text = model.name;
        
        NSString *time = [self timeFormatTranform:model.media_url];
        
        _timeLabel.text = time;
    }
    
}

// 获取一个视屏, 音频文件的播放时长
- (NSUInteger)durationWithVideo:(NSURL *)videoUrl {
    NSDictionary *opts = [NSDictionary dictionaryWithObject:@(NO) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoUrl options:opts]; // 初始化视屏媒体文件
    NSUInteger second = 0;
    second = urlAsset.duration.value / urlAsset.duration.timescale; // 获取视屏总时长, 单位秒
    return second;
}

// 秒 转换成 时:分:秒
- (NSString *)timeFormatTranform:(NSString *)videoUrl {
    
    NSURL *url = [NSURL URLWithString:videoUrl];
    
    NSUInteger second = [self durationWithVideo:url];
    
    NSUInteger seconds = second % 60;
    NSUInteger minutes = (second / 60) % 60;
    NSUInteger hours = second / 3600;
    
    if (hours == 0) {
        return [NSString stringWithFormat:@"%2ld:%2ld",minutes, seconds];
    } else {
        return [NSString stringWithFormat:@"%2ld:%2ld:%2ld", hours, minutes, seconds];
    }
    
}

@end
