//
//  BossCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/13.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "Chameleon.h"
#import "Masonry.h"
#import "BossCell.h"

@implementation BossCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void)addViews{
    [self addSubview:[self image]];
    [self addSubview:[self name]];
}

- (void)defineLayout{
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
        make.bottom.mas_equalTo(self).offset(-10);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.bottom.mas_equalTo(self).offset(-15);
    }];
    
}

- (UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]init];
        _image.contentMode = UIViewContentModeScaleToFill;
        _image.backgroundColor = FlatGreenDark;
    }
    return _image;
}

- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.textAlignment = NSTextAlignmentRight;
        _name.text = @"名字";
        _name.font = [UIFont boldSystemFontOfSize:15];
        _name.textColor = FlatOrangeDark;
    }
    return _name;
}


@end
