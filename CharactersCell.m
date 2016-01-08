//
//  CharactersCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/6.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "CharactersCell.h"

@implementation CharactersCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
        self.backgroundColor =[UIColor whiteColor];
    }
    return self;
}

- (void)addViews{
    [self addSubview:[self image]];
    [self addSubview:[self name]];
    [self addSubview:[self nickname]];
    [self addSubview:[self life]];
    [self addSubview:[self hungry]];
    [self addSubview:[self intellect]];
    self.line1 = [self getLine];
    [self addSubview:[self line1]];
    self.line2 = [self getLine];
    [self addSubview:[self line2]];
    self.line3 = [self getLine];
    [self addSubview:[self line3]];
    self.line4 = [self getLine];
    [self addSubview:[self line4]];
    self.line5 = [self getLine];
    [self addSubview:[self line5]];
    [self addSubview:[self lifeImage]];
    [self addSubview:[self hungryImage]];
    [self addSubview:[self sanityImage]];
}

- (void)defineLayout{
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
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
        make.left.mas_equalTo(self.line2.mas_centerX);
        make.top.mas_equalTo(self.line2.mas_bottom);
        make.height.mas_equalTo(self.name);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.life.mas_bottom);
        make.size.mas_equalTo(self.line1);
    }];
    
    [self.hungry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line2.mas_centerX);
        make.top.mas_equalTo(self.line3.mas_bottom);
        make.height.mas_equalTo(self.name);
    }];
    
    [self.line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.hungry.mas_bottom);
        make.size.mas_equalTo(self.line1);
    }];
    
    [self.intellect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line2.mas_centerX);
        make.top.mas_equalTo(self.line4.mas_bottom);
        make.height.mas_equalTo(self.name);
    }];
    
    [self.line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.intellect.mas_bottom).offset(-2);
        make.size.mas_equalTo(self.line1);
    }];
    
    [self.lifeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.life.mas_left);
        make.centerY.mas_equalTo(self.life);
        CGFloat width = self.frame.size.height * 0.2f * 0.5f;
        make.height.mas_equalTo(width);
        make.width.mas_equalTo(width);
    }];
    
    [self.hungryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.lifeImage);
        make.centerY.mas_equalTo(self.hungry);
        make.size.mas_equalTo(self.lifeImage);
    }];
    
    [self.sanityImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.lifeImage);
        make.centerY.mas_equalTo(self.intellect);
        make.size.mas_equalTo(self.lifeImage);
    }];
}

- (UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]init];
        _image.backgroundColor = [UIColor yellowColor];
    }
    return _image;
}

- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.text = @"名字 ";
        _name.textAlignment = NSTextAlignmentCenter;
        _name.font = [UIFont boldSystemFontOfSize:15];
        _name.textColor = FlatLimeDark;
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


- (UILabel *)life{
    if (!_life) {
        _life = [[UILabel alloc]init];
        _life.textAlignment = NSTextAlignmentCenter;
        _life.font = [UIFont systemFontOfSize:12];
        _life.text = @"123";
    }
    return _life;
}

- (UILabel *)hungry{
    if (!_hungry) {
        _hungry = [[UILabel alloc]init];
        _hungry.textAlignment = NSTextAlignmentCenter;
        _hungry.font = [UIFont systemFontOfSize:12];
        _hungry.text = @"饥饿  ";
    }
    return _hungry;
}

- (UILabel *)intellect{
    if (!_intellect) {
        _intellect = [[UILabel alloc]init];
        _intellect.textAlignment = NSTextAlignmentCenter;
        _intellect.font = [UIFont systemFontOfSize:12];
        _intellect.text = @"散值 ";
    }
    return _intellect;
}

- (UIImageView *)lifeImage{
    if (!_lifeImage) {
        _lifeImage = [[UIImageView alloc]init];
        _lifeImage.image = [UIImage imageNamed:@"life.jpg"];
    }
    return _lifeImage;
}

- (UIImageView *)hungryImage{
    if (!_hungryImage) {
        _hungryImage = [[UIImageView alloc]init];
        _hungryImage.image = [UIImage imageNamed:@"hungry.jpg"];
    }
    return _hungryImage;
}

- (UIImageView *)sanityImage{
    if (!_sanityImage) {
        _sanityImage = [[UIImageView alloc]init];
        _sanityImage.image = [UIImage imageNamed:@"sanity.jpg"];
    }
    return _sanityImage;
}




- (UIView *)getLine{
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = FlatGreenDark;
    return line;
}

@end
