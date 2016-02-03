//
//  SettingHeaderCell.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/27.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "SettingHeaderCell.h"

@implementation SettingHeaderCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void)addViews{
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    
    self.headerImageView = [[UIImageView alloc]init];
    self.headerImageView.layer.cornerRadius = 40;
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.backgroundColor = FlatGrayDark;
    self.headerImageView.layer.borderColor = FlatBlackDark.CGColor;
    self.headerImageView.layer.borderWidth = 1;
    [self addSubview:self.headerImageView];
    
    self.name = [[UILabel alloc]init];
    self.name.font = [UIFont boldSystemFontOfSize:16];
    self.name.text = @"用户名字";
    self.name.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.name];
    
}

- (void)defineLayout{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(self).offset(-10);
    }];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-20);
    }];
}


@end
