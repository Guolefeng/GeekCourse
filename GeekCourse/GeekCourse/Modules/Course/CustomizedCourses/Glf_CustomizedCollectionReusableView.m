//
//  Glf_CustomizedCollectionReusableView.m
//  GeekCourse
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_CustomizedCollectionReusableView.h"
#import "Glf_DataModel.h"

@interface Glf_CustomizedCollectionReusableView ()
@property (nonatomic, retain) UILabel *nameLable;
@end

@implementation Glf_CustomizedCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLable.font = [UIFont systemFontOfSize:20];
        [self addSubview:_nameLable];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _nameLable.frame = CGRectMake(20, 0, self.bounds.size.width, self.bounds.size.height);
}

- (void)setName:(NSString *)name {
    if (_name != name) {
        _name = name;
        _nameLable.text = name;
    }
}

- (void)setModel:(Glf_DataModel *)model {
    if (_model != model) {
        _model = model;
        
        _nameLable.text = model.name;
    }
}

@end
