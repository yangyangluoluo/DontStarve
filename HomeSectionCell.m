//
//  HomeSectionCell.m
//  Geological1
//
//  Created by 李建国 on 15/12/28.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "HomeSectionCell.h"

@implementation HomeSectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self addViews];
        [self defineLayout];
        self.backgroundColor = FlatLimeDark;
    }
    return self;
}

- (void) addViews{
    [self addSubview:[self title]];
    [self addSubview:[self gotoNext]];
}

- (void)defineLayout{
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.gotoNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(3);
        make.bottom.mas_equalTo(self).offset(-3);
        make.right.mas_equalTo(self).offset(-10);
    }];
    
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"标题";
        _title.textAlignment = NSTextAlignmentLeft;
        _title.font = [UIFont systemFontOfSize:15];
    }
    return _title;
}

- (UIButton *)gotoNext{
    if (!_gotoNext) {
        _gotoNext = [[UIButton alloc]init];
        [_gotoNext setTitle:@"显示全部院校" forState:UIControlStateNormal];
        [_gotoNext setTitleColor:FlatGreenDark forState:UIControlStateNormal];
        _gotoNext.titleLabel.font = [UIFont systemFontOfSize:15];
        _gotoNext.titleLabel.layer.borderColor = FlatGreenDark.CGColor;
        _gotoNext.titleLabel.layer.borderWidth = 1;
        _gotoNext.titleLabel.layer.cornerRadius = 2;
        _gotoNext.titleLabel.layer.masksToBounds = YES;
    }
    return _gotoNext;
}


@end
