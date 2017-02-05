//
//  Glf_CommenTableViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/10/18.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CommenTableViewCell.h"

@interface Glf_CommenTableViewCell ()

@property (nonatomic, retain) UILabel *nameLabel;

@end

@implementation Glf_CommenTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_nameLabel];
        
    }
    return self;
}

- (void)setName:(NSString *)name {
    if (_name != name) {
        _name = name;
        
        _nameLabel.text = name;
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
}

@end
