//
//  ImageLabel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/7.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "ImageLabel.h"

@implementation ImageLabel

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void)addViews{
    [self addSubview:[self image]];
    [self addSubview:[self label]];
}

- (void)defineLayout{
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        CGFloat width = self.frame.size.height/2;
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.image.mas_right);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
}

- (UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]init];
        _image.image = [UIImage imageNamed:@"life.jpg"];
    }
    return _image;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.font = [UIFont systemFontOfSize:12];
        _label.text = @"生命值";
    }
    return _label;
}

@end
