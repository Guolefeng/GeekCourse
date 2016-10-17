//
//  Glf_ClearCacheTableViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_ClearCacheTableViewCell.h"

@interface Glf_ClearCacheTableViewCell ()
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *cacheSizeLabel;
@end

@implementation Glf_ClearCacheTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.text = @"清除缓存";
        [self.contentView addSubview:_nameLabel];
        
        self.cacheSizeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_cacheSizeLabel];
        
        [self jxl_setDayMode:^(UIView *view) {
            view.backgroundColor = [UIColor whiteColor];
        } nightMode:^(UIView *view) {
            view.backgroundColor = [UIColor colorWithRed:0 green:0.2 blue:0.1 alpha:1.0];
        }];
        
        [_nameLabel jxl_setDayMode:^(UIView *view) {
            _nameLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            _nameLabel.textColor = [UIColor colorWithRed:0 green:1.0 blue:1.0 alpha:1.0];
        }];
        
        [_cacheSizeLabel jxl_setDayMode:^(UIView *view) {
            _cacheSizeLabel.textColor = [UIColor blackColor];
        } nightMode:^(UIView *view) {
            _cacheSizeLabel.textColor = [UIColor colorWithRed:0 green:1.0 blue:1.0 alpha:1.0];
            
        }];
    }
    return self;
}

- (void)setCacheSizeString:(NSString *)cacheSizeString {
    if (_cacheSizeString!= cacheSizeString) {
        _cacheSizeString = cacheSizeString;
        
        _cacheSizeLabel.text = cacheSizeString;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(@150);
    }];
    
    [_cacheSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30);
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(@50);
    }];

}


@end
