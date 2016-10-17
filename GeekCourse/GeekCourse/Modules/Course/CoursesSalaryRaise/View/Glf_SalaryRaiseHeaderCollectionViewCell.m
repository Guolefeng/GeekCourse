//
//  Glf_SalaryRaiseHeaderCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/26.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_SalaryRaiseHeaderCollectionViewCell.h"

@interface Glf_SalaryRaiseHeaderCollectionViewCell ()

@property (nonatomic, retain)UILabel *lineLabel;

@end

@implementation Glf_SalaryRaiseHeaderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
        
        self.lineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_lineLabel];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        
        self.label.text = title;
    }
    
    if ([_label.text isEqualToString:@"全部"]) {
        _label.textColor = [UIColor redColor];
        _label.font = [UIFont systemFontOfSize:20];
        _lineLabel.backgroundColor = [UIColor redColor];
    }
    
}

- (void)changeSurfaceWith:(BOOL)YesOrNo {
    if (YesOrNo) {
        _label.textColor = [UIColor redColor];
        _label.font = [UIFont systemFontOfSize:20];
        _lineLabel.backgroundColor = [UIColor redColor];
    } else {
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:17];
        _lineLabel.backgroundColor = [UIColor whiteColor];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.contentView.bounds;
    self.lineLabel.frame = CGRectMake(0, _label.frame.size.height - 3, _label.frame.size.width, 3);
}



@end
