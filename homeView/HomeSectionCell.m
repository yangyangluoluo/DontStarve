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

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void) addViews{
    [self addSubview:[self title]];
}

- (void)defineLayout{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"标题";
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:15];
    }
    return _title;
}

@end
