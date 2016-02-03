//
//  PictureCell.m
//  Geological1
//
//  Created by 李建国 on 16/1/1.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "PictureCell.h"

#define LEFT 40

@implementation PictureCell

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
    [self addSubview:[self portrait]];
    [self addSubview:[self nickname]];
    [self addSubview:[self date]];
    [self addSubview:[self describe]];
    [self addSubview:[self image1]];
    [self addSubview:[self image2]];
    [self addSubview:[self image3]];
    [self addSubview:[self image4]];
    [self addSubview:[self image5]];
    [self addSubview:[self image6]];
    [self addSubview:[self line1]];
    [self addSubview:[self commnetNum]];
    [self addSubview:[self comment]];
    self.line2 = [[UIView alloc]init];
    self.line2.backgroundColor = FlatGreenDark;
    [self addSubview:self.line2];
    self.images = @[self.image1,self.image2,self.image3,self.image4,self.image5,self.image6];
}

- (void)defineLayout{
    [self.portrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(1);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.portrait.mas_right).offset(10);
        make.bottom.mas_equalTo(self.portrait);
    }];
    
    [self.nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.date.mas_top).offset(-2);
        make.left.mas_equalTo(self.date);
    }];
    
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.portrait.mas_bottom).offset(5);
    }];
    
    [self.image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self.describe.mas_bottom).offset(10);
        CGFloat width = (self.frame.size.width - LEFT)/3;
        make.size.mas_equalTo(CGSizeMake(width,width));
    }];
    
    [self.image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self.image1);
        CGFloat width = (self.frame.size.width - LEFT)/3;
        make.size.mas_equalTo(CGSizeMake(width,width));
    }];
    
    [self.image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-20);
        make.centerY.mas_equalTo(self.image1);
        CGFloat width = (self.frame.size.width - LEFT)/3;
        make.size.mas_equalTo(CGSizeMake(width,width));
    }];
    
    [self.image4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self.image1.mas_bottom).offset(1);
        CGFloat width = (self.frame.size.width - LEFT)/3;
        make.size.mas_equalTo(CGSizeMake(width,width));
    }];
    
    [self.image5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self.image4);
        CGFloat width = (self.frame.size.width - LEFT)/3;
        make.size.mas_equalTo(CGSizeMake(width,width));
    }];
    
    [self.image6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-20);
        make.centerY.mas_equalTo(self.image4);
        CGFloat width = (self.frame.size.width - LEFT)/3;
        make.size.mas_equalTo(CGSizeMake(width,width));
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.bottom.mas_equalTo(self.commnetNum.mas_top);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.commnetNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self).offset(-4);
        make.top.mas_equalTo(self.line1).offset(4);
    }];
    
    
}

- (CALayer *)calayer{
    if (!_calayer) {
        _calayer = [CALayer layer];
        CGRect frame = self.bounds;
        frame.origin.x = 10;
        frame.size.width -= 20;
        _calayer.frame = frame;
        _calayer.backgroundColor = [UIColor whiteColor].CGColor;
        _calayer.cornerRadius = 10;
        _calayer.masksToBounds = YES;
    }
    return _calayer;
}

- (UIImageView *)portrait{
    if (!_portrait) {
        _portrait = [[UIImageView alloc]init];
        _portrait.backgroundColor = [UIColor blackColor];
        _portrait.layer.cornerRadius = 20;
        _portrait.layer.masksToBounds = YES;
        _portrait.layer.borderColor = FlatGreenDark.CGColor;
        _portrait.layer.borderWidth = 1;
    }
    return _portrait;
}

- (UILabel *)nickname{
    if (!_nickname) {
        _nickname = [[UILabel alloc]init];
        _nickname.text = @"昵称";
        _nickname.font = [UIFont systemFontOfSize:16];
        _nickname.textColor = FlatPurpleDark;
    }
    return _nickname;
}

- (UILabel *)date{
    if (!_date) {
        _date = [[UILabel alloc]init];
        _date.text = @"日期";
        _date.font = [UIFont systemFontOfSize:12];
        _date.alpha = 0.5;
    }
    return _date;
}

- (UILabel *)describe{
    if (!_describe) {
        _describe = [[UILabel alloc]init];
        _describe.text = @"描述";
        _describe.font = [UIFont systemFontOfSize:18];
        _describe.numberOfLines = 0;
        _describe.lineBreakMode = NSLineBreakByCharWrapping;
        _describe.preferredMaxLayoutWidth = self.frame.size.width - 40;
    }
    return _describe;
}

- (UIImageView *)image1{
    if (!_image1) {
        _image1 = [[UIImageView alloc]init];
        _image1.userInteractionEnabled = YES;
        
    }
    return _image1;
}

- (UIImageView *)image2{
    if (!_image2) {
        _image2 = [[UIImageView alloc]init];
        _image2.userInteractionEnabled = YES;
    }
    return _image2;
}

- (UIImageView *)image3{
    if (!_image3) {
        _image3 = [[UIImageView alloc]init];
        _image3.userInteractionEnabled = YES;
    }
    return _image3;
}

- (UIImageView *)image4{
    if (!_image4) {
        _image4 = [[UIImageView alloc]init];
        _image4.userInteractionEnabled = YES;
    }
    return _image4;
}

- (UIImageView *)image5{
    if (!_image5) {
        _image5 = [[UIImageView alloc]init];
        _image5.userInteractionEnabled = YES;
        
    }
    return _image5;
}

- (UIImageView *)image6{
    if (!_image6) {
        _image6 = [[UIImageView alloc]init];
        _image6.userInteractionEnabled = YES;
        
    }
    return _image6;
}

- (UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = FlatGreenDark;
    }
    return _line1;
}

- (UILabel *)commnetNum{
    if (!_commnetNum) {
        _commnetNum = [[UILabel alloc]init];
        _commnetNum.text = @"评论数目";
        _commnetNum.font = [UIFont systemFontOfSize:15];
        _commnetNum.textAlignment = NSTextAlignmentCenter;
        _commnetNum.textColor = FlatGreenDark;
    }
    return _commnetNum;
}

- (UIButton *)comment{
    if (!_comment) {
        _comment = [[UIButton alloc]init];
        [_comment setTitle:@"查看评论" forState:UIControlStateNormal];
        [_comment setTitleColor:FlatGreenDark forState:UIControlStateNormal];
        _comment.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _comment;
}








@end
