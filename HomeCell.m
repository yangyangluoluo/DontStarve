//
//  HomeCell.m
//  Geological1
//
//  Created by 李建国 on 15/12/28.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "HomeCell.h"

@implementation HomeCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addViews{
    [self addSubview:[self image]];
    [self addSubview:[self title]];
}

- (void)defineLayout{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(1);
        make.right.mas_equalTo(self).offset(-1);
        make.bottom.mas_equalTo(self);
    }];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(1);
        make.right.mas_equalTo(self).offset(-1);
        make.top.mas_equalTo(self).offset(1);
        make.bottom.mas_equalTo(self.title).offset(-1);
    }];
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"标题";
        _title.backgroundColor = [UIColor clearColor];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor whiteColor];
        _title.font = [UIFont systemFontOfSize:12];
    }
    return _title;
}

- (UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]init];
        _image.image = [UIImage imageNamed:@"1.jpg"];
        _image.contentMode = UIViewContentModeScaleToFill;
    }
    return _image;
}



@end
