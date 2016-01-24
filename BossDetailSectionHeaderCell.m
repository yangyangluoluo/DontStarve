//
//  BossDetailSectionHeaderCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/14.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "Chameleon.h"
#import "Masonry.h"
#import "BossDetailSectionHeaderCell.h"

@implementation BossDetailSectionHeaderCell

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
}

- (void)defineLayout{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self).offset(10);
        make.bottom.mas_equalTo(self);
    }];
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"标题";
        _title.font = [UIFont boldSystemFontOfSize:15];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.backgroundColor = FlatGreenDark;
    }
    return _title;
}

@end
