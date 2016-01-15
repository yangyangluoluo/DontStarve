//
//  BossDetailCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/13.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "Chameleon.h"
#import "Masonry.h"
#import "BossDetailCell.h"

@implementation BossDetailCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void)addViews{
    [self addSubview:[self title]];
    [self addSubview:[self line]];
    [self addSubview:[self describe]];
}

- (void)defineLayout{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self).offset(5);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title);
        make.right.mas_equalTo(self.title);
        make.top.mas_equalTo(self.title.mas_bottom).offset(2);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title);
        make.right.mas_equalTo(self.title);
        make.top.mas_equalTo(self.line.mas_bottom).offset(1);
    }];
    
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textColor = FlatLimeDark;
        _title.font = [UIFont systemFontOfSize:15];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.text = @"标题";
    }
    return _title;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = FlatGreenDark;
    }
    return _line;
}

- (UILabel *)describe{
    if (!_describe) {
        _describe = [[UILabel alloc]init];
        _describe.font = [UIFont systemFontOfSize:13];
        _describe.lineBreakMode = NSLineBreakByCharWrapping;
        _describe.numberOfLines = 0;
        _describe.preferredMaxLayoutWidth = self.frame.size.width - 20;
        _describe.text = @"描述";
        _describe.textColor = FlatBlackDark;
        _describe.textAlignment = NSTextAlignmentCenter;
    }
    return _describe;
}


@end
