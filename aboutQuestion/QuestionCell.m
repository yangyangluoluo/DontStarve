//
//  QuestionCell.m
//  Geological1
//
//  Created by 李建国 on 15/12/27.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "QuestionCell.h"

@implementation QuestionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addViews{
    [self addSubview:[self portrait]];
    [self addSubview:[self title]];
    [self addSubview:[self date]];
    
    [self addSubview:[self nickname]];
    [self addSubview:[self line1]];
    [self addSubview:[self describe]];
    [self addSubview:[self line2]];
    [self addSubview:[self replyNum]];
    [self addSubview:[self showComments]];
    
    self.line3 = [[UIView alloc]init];
    self.line3.backgroundColor = FlatGreenDark;
    [self addSubview:[self line3]];
}

- (void)defineLayout{
    
    [self.portrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.portrait.mas_right).offset(5);
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(2);
    }];
    
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickname);
        make.top.mas_equalTo(self.nickname.mas_bottom);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(5);
        make.right.mas_equalTo(self).offset(-5);
        make.top.mas_equalTo(self).offset(42);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.right.mas_equalTo(self.line2);
        make.top.mas_equalTo(self.line1.mas_top);
        make.height.mas_equalTo(30);
    }];
    
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.right.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.title.mas_bottom);
        make.bottom.mas_equalTo(self.line2).offset(-10);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.right.mas_equalTo(self.line1);
        make.bottom.mas_equalTo(self.replyNum.mas_top);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.replyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(30);
    }];
    
    [self.showComments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_centerX);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.line2).offset(4);
        make.bottom.mas_equalTo(self).offset(-4);
        make.width.mas_equalTo(0.5);
    }];
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

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"标题";
        _title.font = [UIFont boldSystemFontOfSize:15];
        _title.textColor = FlatOrangeDark;
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

- (UILabel *)date{
    if (!_date) {
        _date = [[UILabel alloc]init];
        _date.text = @"起始日期";
        _date.font = [UIFont systemFontOfSize:12];
    }
    return _date;
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

- (UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = FlatGreenDark;
    }
    return _line1;
}

- (UILabel *)describe{
    if (!_describe) {
        _describe = [[UILabel alloc]init];
        _describe.text = @"描述";
        _describe.font = [UIFont systemFontOfSize:14];
        _describe.numberOfLines = 0;
        _describe.lineBreakMode = NSLineBreakByCharWrapping;
        _describe.preferredMaxLayoutWidth = self.frame.size.width - 10;
        _describe.backgroundColor = FlatWhiteDark;
    }
    return _describe;
}

- (UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc]init];
        _line2.backgroundColor = FlatGreenDark;
    }
    return _line2;
}

- (UILabel *)replyNum{
    if (!_replyNum) {
        _replyNum = [[UILabel alloc]init];
        _replyNum.text = @"回答个数";
        _replyNum.textAlignment = NSTextAlignmentCenter;
        _replyNum.font = [UIFont systemFontOfSize:15];
        _replyNum.textColor = FlatGreenDark;
    }
    return _replyNum;
}

- (UIButton *)showComments{
    if (!_showComments) {
        _showComments = [[UIButton alloc]init];
        [_showComments setTitle:@"查看回答" forState:UIControlStateNormal];
        [_showComments setTitleColor:FlatGreenDark forState:UIControlStateNormal];
        _showComments.titleLabel.font = [UIFont systemFontOfSize:15];

    }
    return _showComments;
}


@end
