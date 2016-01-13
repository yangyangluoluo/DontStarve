//
//  BossDetailHeadCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/13.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "BossDetailHeadCell.h"

@implementation BossDetailHeadCell
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void)addViews{
    /*从CELL下面向上面布局*/
    [self  addSubview:[self bgView]];
    [self.bgView  addSubview:[self image]];
    self.line4 = [self getLine];
    [self.bgView addSubview:[self line4]];
    self.line3 = [self getLine];
    [self.bgView addSubview:[self line3]];
    self.line2 = [self getLine];
    [self addSubview:[self line2]];
    self.line1 = [self getLine];
    [self.bgView addSubview:[self line1]];
    [self.bgView addSubview:[self chName]];
    [self.bgView addSubview:[self enName]];
    [self.bgView addSubview:[self bossType]];
    [self.bgView addSubview:[self life]];
    
}

- (void)defineLayout{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = self.frame.size.height - 10;
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.bottom.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(height);
    }];
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = self.frame.size.height - 10;
        make.left.mas_equalTo(self.bgView);
        make.bottom.mas_equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(height, height));
    }];
    
    [self.line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.image.mas_right).offset(5);
        make.right.mas_equalTo(self.bgView).offset(-5);
        make.bottom.mas_equalTo(self.bgView).offset(-1);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line4);
        make.size.mas_equalTo(self.line4);
        CGFloat distance = self.frame.size.height/4;
        make.bottom.mas_equalTo(self.bgView).offset(-distance);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line4);
        make.size.mas_equalTo(self.line4);
        CGFloat distance = self.frame.size.height/2;
        make.bottom.mas_equalTo(self.bgView).offset(-distance);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line4);
        make.size.mas_equalTo(self.line4);
        CGFloat distance = self.frame.size.height/4*3;
        make.bottom.mas_equalTo(self.bgView).offset(-distance);
    }];
    
    [self.chName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.right.mas_equalTo(self.line1);
        make.bottom.mas_equalTo(self.line1);
        CGFloat height = self.frame.size.height/4;
        make.height.mas_equalTo(height);
    }];
    
    [self.enName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.right.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.line1);
        make.bottom.mas_equalTo(self.line2);
    }];
    
    [self.bossType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.right.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.line2);
        make.bottom.mas_equalTo(self.line3);
    }];
    
    [self.life mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat height = self.frame.size.height/4;
        make.left.mas_equalTo(self.line1);
        make.right.mas_equalTo(self.line1);
        make.bottom.mas_equalTo(self.line4);
        make.height.mas_equalTo(height);
    }];
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]init];
        _image.contentMode = UIViewContentModeScaleToFill;
        _image.backgroundColor = FlatGreenDark;
        _image.layer.cornerRadius = 5;
        _image.layer.masksToBounds = YES;
    }
    return _image;
}

- (UIView *)getLine{
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = FlatGreenDark;
    return line;
}

- (UILabel *)chName{
    if (!_chName) {
        _chName = [[UILabel alloc]init];
        _chName.text = @"中文名字";
        _chName.textColor = FlatLimeDark;
        _chName.font = [UIFont boldSystemFontOfSize:18];
        _chName.textAlignment = NSTextAlignmentCenter;
    }
    return _chName;
}

- (UILabel *)enName{
    if (!_enName) {
        _enName = [[UILabel alloc]init];
        _enName.text = @"英文名称";
        _enName.font = [UIFont systemFontOfSize:14];
        _enName.textAlignment = NSTextAlignmentCenter;
    }
    return _enName;
}

- (UILabel *)bossType{
    if (!_bossType) {
        _bossType = [[UILabel alloc]init];
        _bossType.text = @"BOSSTYPE";
        _bossType.font = [UIFont systemFontOfSize:14];
        _bossType.textAlignment = NSTextAlignmentCenter;
    }
    return _bossType;
    
}

- (UILabel *)life{
    if (!_life) {
        _life = [[UILabel alloc]init];
        _life.text = @"生命值";
        _life.font = [UIFont systemFontOfSize:14];
        _life.textAlignment = NSTextAlignmentCenter;
    }
    return _life;
}
     
     
     
     
     
     
     
     

@end
