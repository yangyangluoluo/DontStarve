//
//  CommentCell.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/28.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "CommentCell.h"

@implementation CommentCell

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
    [self addSubview:[self date]];
    [self addSubview:[self nickname]];
    [self addSubview:[self describe]];
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
    
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.portrait.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self);
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

- (UILabel *)describe{
    if (!_describe) {
        _describe = [[UILabel alloc]init];
        _describe.text = @"描述";
        _describe.font = [UIFont systemFontOfSize:16];
        _describe.numberOfLines = 0;
        _describe.lineBreakMode = NSLineBreakByCharWrapping;
        _describe.preferredMaxLayoutWidth = self.frame.size.width - 10;
        _describe.backgroundColor = FlatWhiteDark;
    }
    return _describe;
}

@end
