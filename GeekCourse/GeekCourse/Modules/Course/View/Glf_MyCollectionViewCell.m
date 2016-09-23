//
//  Glf_MyCollectionViewCell.m
//  GeekCourse
//
//  Created by dllo on 16/9/22.
//  Copyright © 2016年 Guolefeng. All rights reserved.
//

#import "Glf_MyCollectionViewCell.h"
#import "Glf_ModelOfCourse.h"

@interface Glf_MyCollectionViewCell ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *label;

@end

@implementation Glf_MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor redColor];
         _imageView.image = [UIImage imageNamed:_modelOfCourse.practiseImageName];
        [self.contentView addSubview:_imageView];
       
        self.label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor blueColor];
        _label.text = _modelOfCourse.practiseName;
        [self.contentView addSubview:_label];
    }
    return self;
}

//- (void)setModelOfCourse:(Glf_ModelOfCourse *)modelOfCourse {
//    if (_modelOfCourse != modelOfCourse) {
//        _modelOfCourse = modelOfCourse;
//        
//        _imageView.image = [UIImage imageNamed:modelOfCourse.practiseImageName];
//        _label.text = modelOfCourse.practiseName;
//    }
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 30);
    _label.frame = CGRectMake(0, self.contentView.frame.size.height - 30, self.contentView.frame.size.width, 30);
}

@end
