//
//  AnimalDetailCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/9.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "AnimalDetailCell.h"

@implementation AnimalDetailCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void)addViews{
    [self addSubview:[self title]];
    self.line1 = [self getLine];
    [self addSubview:[self line1]];
    [self addSubview:[self describe]];
    self.line2 = [self getLine];
    [self addSubview:[self line2]];
}

- (void)defineLayout{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(5);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self);
        CGFloat width = self.frame.size.width/2;
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(width);
    }];
    
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(2);
        make.right.mas_equalTo(self).offset(-2);
        make.top.mas_equalTo(self.line1.mas_bottom).offset(5);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(1);
        make.right.mas_equalTo(self).offset(-1);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
        make.height.mas_equalTo(1.5);
    }];
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"标题";
        _title.font = [UIFont boldSystemFontOfSize:14];
    }
    return _title;
}

- (UIView *)getLine{
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = FlatGreenDark;
    return line;
}

- (UILabel *)describe{
    if (!_describe) {
        _describe = [[UILabel alloc]init];
        _describe.text = @"描述";
        _describe.font = [UIFont systemFontOfSize:14];
        _describe.textAlignment = NSTextAlignmentCenter;
        _describe.numberOfLines = 0;
        _describe.lineBreakMode = NSLineBreakByCharWrapping;
        _describe.preferredMaxLayoutWidth = self.frame.size.width - 10;
        _describe.textColor = FlatOrangeDark;
    }
    return _describe;
}




@end
