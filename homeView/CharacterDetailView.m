//
//  CharacterDetailView.m
//  DontStarve
//
//  Created by 李建国 on 16/1/7.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "CharacterDetailView.h"

@implementation CharacterDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void)addViews{
    [self addSubview:[self header]];
    self.unlock = [self getLLL];
    self.unlock.title.text = @"解锁条件";
    [self addSubview:[self unlock]];
    self.ability = [self getLLL];
    self.ability.title.text = @"特殊能力";
    [self addSubview:[self ability]];
    self.introduce = [self getLLL];
    self.introduce.title.text = @"人物简介";
    [self addSubview:[self introduce]];
    [self addSubview:[self getComments]];
}

- (void)defineLayout{
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        CGFloat height = self.frame.size.width * 0.5;
        make.height.mas_equalTo(height);
    }];
    
    [self.unlock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.header.mas_bottom).offset(10);
    }];
    
    [self.ability mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.unlock.mas_bottom).offset(10);
    }];
    
    [self.introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.ability.mas_bottom).offset(10);
    }];
    
    [self.getComments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.introduce.mas_bottom).offset(10);
        make.height.mas_equalTo(50);
    }];
    

    
}

- (DetailHead *)header{
    if (!_header) {
        CGRect frame = CGRectMake(200, 10, self.frame.size.width, self.frame.size.width * 0.5);
        _header = [[DetailHead alloc]initWithFrame:frame];
        _header.backgroundColor = [UIColor whiteColor];
    }
    return _header;
}

- (LabelLineLabel *)getLLL{
    LabelLineLabel *LLL = [[LabelLineLabel alloc]init];
    LLL.backgroundColor = [UIColor whiteColor];
    return LLL;
}

- (UIButton *)getComments{
    if (!_getComments) {
        _getComments = [[UIButton alloc]init];
        _getComments.backgroundColor = [UIColor whiteColor];
    }
    return _getComments;
}






@end
