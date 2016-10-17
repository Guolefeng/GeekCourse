//
//  Glf_NightModeTableViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_NightModeTableViewCell.h"

@interface Glf_NightModeTableViewCell ()

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UISwitch *nightModeSwitch;

@end

@implementation Glf_NightModeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.text = @"夜间模式";
        [self.contentView addSubview:_nameLabel];
        
        self.nightModeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        [_nightModeSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_nightModeSwitch];
        
        [self jxl_setDayMode:^(UIView *view) {
            view.backgroundColor = [UIColor whiteColor];
        } nightMode:^(UIView *view) {
            view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.5 alpha:1.0];
        }];
        
        [_nameLabel jxl_setDayMode:^(UIView *view) {
            _nameLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            _nameLabel.textColor = [UIColor colorWithRed:0 green:1.0 blue:1.0 alpha:1.0];
        }];
        
        if ([[JXLDayAndNightManager shareManager] contentMode] == JXLDayAndNightModeDay) {
            _nightModeSwitch.on = NO;
        } else {
            _nightModeSwitch.on = YES;
        }
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(@150);
    }];
    
    [_nightModeSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
}

- (void)switchChange:(UISwitch *)switchView {
    if (switchView.on) {
        [[JXLDayAndNightManager shareManager] nightMode];
    } else {
        [[JXLDayAndNightManager shareManager] dayMode];
    }
}

@end
