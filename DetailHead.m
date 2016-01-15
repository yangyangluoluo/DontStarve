//
//  DetailHead.m
//  DontStarve
//
//  Created by 李建国 on 16/1/7.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "DetailHead.h"

@implementation DetailHead

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
    [self addSubview:[self name]];
    [self addSubview:[self nickname]];
    
    self.life = [self getImageLabel];
    self.life.image.image = [UIImage imageNamed:@"life.jpg"];
    self.life.label.text = @"生命";
    [self addSubview:[self life]];
    self.hungry = [self getImageLabel];
    self.hungry.image.image = [UIImage imageNamed:@"hungry.jpg"];
    self.hungry.label.text = @"jier";
    [self addSubview:[self hungry]];
    self.sanity = [self getImageLabel];
    self.sanity.image.image = [UIImage imageNamed:@"sanity.jpg"];
    self.sanity.label.text = @"snazhi";
    [self addSubview:[self sanity]];
    self.atk = [self getImageLabel];
    self.atk.image.image = [UIImage imageNamed:@"atk.png"];
    self.atk.label.text = @"gongji";
    [self addSubview:[self atk]];
    self.line1 = [self getLine];
    [self addSubview:[self line1]];
    self.line2 = [self getLine];
    [self addSubview:[self line2]];
    self.line3 = [self getLine];
    [self addSubview:[self line3]];
    self.line4 = [self getLine];
    [self addSubview:[self line4]];
    [self addSubview:[self motto]];
}

- (void)defineLayout{
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(2);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        CGFloat width = self.frame.size.height * 0.75;
        make.width.mas_equalTo(width);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = self.frame.size.height * 0.2f;
        make.left.mas_equalTo(self.image.mas_right).offset(2);
        make.right.mas_equalTo(self).offset(-2);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(height);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.name);
        make.right.mas_equalTo(self.name);
        make.top.mas_equalTo(self.name.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line1.mas_bottom);
        make.height.mas_equalTo(self.name);
        make.centerX.mas_equalTo(self.line1);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.nickname.mas_bottom);
        make.size.mas_equalTo(self.line1);
    }];
    
    [self.life mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.line2).offset(2);
        make.height.mas_equalTo(self.frame.size.height * 0.1f);
        make.right.mas_equalTo(self.line1.mas_centerX);
    }];
    
    [self.hungry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.life.mas_right);
        make.centerY.mas_equalTo(self.life);
        make.size.mas_equalTo(self.life);
    }];
    
    [self.sanity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.life);
        make.top.mas_equalTo(self.life.mas_bottom).offset(2);
        make.size.mas_equalTo(self.life);
    }];
    
    [self.atk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sanity.mas_right);
        make.centerY.mas_equalTo(self.sanity);
        make.size.mas_equalTo(self.life);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = self.frame.size.height * 0.6f+8;
        make.top.mas_equalTo(self).offset(height);
        make.left.mas_equalTo(self.line1);
        make.width.mas_equalTo(self.line1);
        make.height.mas_equalTo(2);
    }];
    
    [self.motto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.right.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.line3.mas_bottom);
        make.bottom.mas_equalTo(self.line4.mas_top);
    }];
    
    [self.line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.mas_bottom).offset(-2);
        make.width.mas_equalTo(self.line1);
        make.height.mas_equalTo(2);
    }];
}

- (UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]init];
        _image.backgroundColor = [UIColor yellowColor];
        _image.contentMode = UIViewContentModeScaleToFill;
        _image.image = [UIImage imageNamed:@"test.jpg"];
    }
    return _image;
}

- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.text = @"名字 ";
        _name.textAlignment = NSTextAlignmentCenter;
        _name.font = [UIFont boldSystemFontOfSize:15];
        _name.textColor = FlatGreenDark;
    }
    return _name;
}

- (UILabel *)nickname{
    if (!_nickname) {
        _nickname = [[UILabel alloc]init];
        _nickname.textAlignment = NSTextAlignmentCenter;
        _nickname.font = [UIFont systemFontOfSize:15];
        _nickname.text = @"昵称   ";
    }
    return _nickname;
}

- (UIView *)getLine{
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = FlatGreenDark;
    return line;
}

- (UILabel *)motto{
    if (!_motto) {
        _motto = [[UILabel alloc]init];
        _motto.text = @"一切东西在燃烧时更加绚丽,一切东西在燃烧时更加绚丽";
        _motto.lineBreakMode = NSLineBreakByCharWrapping;
        _motto.numberOfLines = 0;
        _motto.textAlignment = NSTextAlignmentCenter;
        _motto.font = [UIFont boldSystemFontOfSize:14];
        _motto.textColor = FlatOrangeDark;
    }
    return _motto;
}

- (ImageLabel *)getImageLabel{
    CGRect frame = CGRectMake(0, 0,self.frame.size.height * 0.75/4, self.frame.size.height * 0.1f);
    ImageLabel *imageLabel = [[ImageLabel alloc]initWithFrame:frame];
    imageLabel.backgroundColor = [UIColor whiteColor];
    return imageLabel;
}


@end
