//
//  SettingCell.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/27.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "SettingCell.h"

@implementation SettingCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void)addViews{
    self.line1 = [[UIView alloc]init];
    self.line1.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.line1];
    
    self.line2 = [[UIView alloc]init];
    self.line2.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.line2];
    
    self.describe = [[UILabel alloc]init];
    self.describe.text = @"描述";
    self.describe.font = [UIFont systemFontOfSize:16];
    self.describe.textAlignment = NSTextAlignmentCenter;
    [self addSubview:[self describe]];
    
}

- (void)defineLayout{
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(5);
        make.right.mas_equalTo(self).offset(-5);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(5);
        make.right.mas_equalTo(self).offset(-5);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
 
}



@end
