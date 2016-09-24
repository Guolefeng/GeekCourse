//
//  Glf_MyTableViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/23.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_MyTableViewCell.h"
#import "Masonry.h"
#import <UIImageView+WebCache.h>
#import "Glf_ModelOfCourse.h"

@interface Glf_MyTableViewCell ()

@property (nonatomic, retain) UIImageView *cellImageView;
@property (nonatomic, retain) UILabel *cellNameLabel;
@property (nonatomic, retain) UIImageView *cellUserImageView;
@property (nonatomic, retain) UILabel *cellNumberLabel;
@property (nonatomic, retain) UILabel *cellUpDataLabel;

@end

@implementation Glf_MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 150, 100)];
        _cellImageView.backgroundColor = [UIColor grayColor];
        
        
        [self.contentView addSubview:_cellImageView];
        
        self.cellNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _cellNameLabel.numberOfLines = 0;
        [_cellNameLabel sizeToFit];

        [self.contentView addSubview:_cellNameLabel];
        [_cellNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_cellImageView).offset(160);
            make.top.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-20);
            make.height.equalTo(@60);
        }];
        
        self.cellUserImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _cellUserImageView.image = [UIImage imageNamed:@"user"];
        [self.contentView addSubview:_cellUserImageView];
        [_cellUserImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_cellImageView).offset(160);
            make.top.equalTo(_cellNameLabel).offset(75);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        self.cellNumberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [self.contentView addSubview:_cellNumberLabel];
        [_cellNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_cellUserImageView).offset(22);
            make.top.equalTo(_cellNameLabel).offset(70);
            make.width.equalTo(@100);
            make.height.equalTo(@30);
        }];
        
        self.cellUpDataLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _cellUpDataLabel.backgroundColor = [UIColor whiteColor];
        _cellUpDataLabel.text = @"更新完成";
        [self.contentView addSubview:_cellUpDataLabel];
        [_cellUpDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(_cellNameLabel).offset(70);
            make.left.equalTo(_cellNumberLabel).offset(110);
            make.height.equalTo(@30);
        }];
    }
    return self;
}

- (void)setNumbers:(NSString *)numbers {
    if (_numbers != numbers) {
        _numbers = numbers;
        
        _cellNumberLabel.text = numbers;
    }
}
- (void)setTableViewCellModel:(Glf_ModelOfCourse *)tableViewCellModel {
    if (_tableViewCellModel != tableViewCellModel) {
        _tableViewCellModel = tableViewCellModel;
        
        NSURL *url = [NSURL URLWithString:tableViewCellModel.pic];
        [_cellImageView sd_setImageWithURL:url];
        
        _cellNameLabel.text = tableViewCellModel.name;
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
