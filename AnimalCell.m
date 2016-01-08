//
//  AnimalCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/8.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "AnimalCell.h"

@implementation AnimalCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void)addViews{
    [self addSubview:[self image]];
    [self addSubview:[self chName]];
    self.line1 = [self getLine];
    [self addSubview:[self line1]];
    [self addSubview:[self enName]];
    self.line2 = [self getLine];
    [self addSubview:[self line2]];
    [self addSubview:[self type]];
    self.line3 = [self getLine];
    [self addSubview:[self line3]];
}

- (void)defineLayout{
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(5);
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = self.frame.size.height/3;
        make.left.mas_equalTo(self.image.mas_right).offset(5);
        make.right.mas_equalTo(self).offset(-5);
        make.top.mas_equalTo(self).offset(height);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.chName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.line1);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self.line1.mas_top);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = self.frame.size.height/3*2;
        make.left.mas_equalTo(self.line1);
        make.top.mas_equalTo(self).offset(height);
        make.size.mas_equalTo(self.line1);
    }];
    
    [self.enName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.line1.mas_bottom);
        make.bottom.mas_equalTo(self.line2.mas_top);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.bottom.mas_equalTo(self).offset(-2);
        make.size.mas_equalTo(self.line1);
    }];
    
    [self.type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.line2.mas_bottom);
        make.bottom.mas_equalTo(self.line3.mas_top);
    }];
    
    
}

- (UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]init];
        _image.backgroundColor = [UIColor whiteColor];
    }
    return _image;
}

- (UILabel *)chName{
    if (!_chName) {
        _chName = [[UILabel alloc]init];
        _chName.textColor = FlatLimeDark;
        _chName.font = [UIFont boldSystemFontOfSize:18];
        _chName.text = @"中文名称";
    }
    return _chName;
}

- (UIView *)getLine{
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = FlatGreenDark;
    return line;
}

- (UILabel *)enName{
    if (!_enName) {
        _enName = [[UILabel alloc]init];
        _enName.font =[UIFont systemFontOfSize:16];
        _enName.text = @"英文名称";
    }
    return _enName;
}

- (UILabel *)type{
    if (!_type) {
        _type = [[UILabel alloc]init];
        _type.font = [UIFont systemFontOfSize:16];
        _type.text = @"类型";
    }
    return _type;
}






@end
