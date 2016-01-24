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
    [self addSubview:[self chName]];
    [self addSubview:[self enName]];
    self.line1 = [self getLine];
    [self addSubview:self.line1];
    self.line2 = [self getLine];
    [self addSubview:self.line2];
}

- (void)defineLayout{
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(5);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(36, 51));
    }];
    
    [self.chName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.image.mas_bottom);
    }];
    
    [self.enName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.chName.mas_bottom);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(1);
    }];

}

- (UILabel *)chName{
    if (!_chName) {
        _chName = [[UILabel alloc]init];
        _chName.text = @"标题";
        _chName.textAlignment = NSTextAlignmentCenter;
        _chName.font = [UIFont systemFontOfSize:14];
        _chName.textColor = FlatGreenDark;
    }
    return _chName;
}

- (UILabel *)enName{
    if (!_enName) {
        _enName = [[UILabel alloc]init];
        _enName.text = @"标题";
        _enName.textAlignment = NSTextAlignmentCenter;
        _enName.font = [UIFont systemFontOfSize:14];
    }
    return _enName;
}

- (UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]init];
        _image.contentMode = UIViewContentModeScaleToFill;
    }
    return _image;
}

- (UIView *)getLine{
    UIView *line = [[UIView alloc]init];
    line.layer.backgroundColor = FlatGreenDark.CGColor;
    return line;
}


@end
