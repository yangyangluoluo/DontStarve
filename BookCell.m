//
//  BookCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/26.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BookCell.h"

@implementation BookCell

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
    self.raw1 = [self getImageLabel];
    [self addSubview:[self raw1]];
    self.raw2 = [self getImageLabel];
    [self addSubview:[self raw2]];
    self.raw3 = [self getImageLabel];
    [self addSubview:[self raw3]];
    self.raws = @[self.raw1,self.raw2,self.raw3];
    
    self.oneDescribe = [self getDescribLabel];
    self.oneDescribe.text = @"书本简介";
    [self addSubview:[self oneDescribe]];
    self.one = [self getLabel];
    [self addSubview:[self one]];
}

- (void)defineLayout{
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(70.0f, 70.0f));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self.image);
        make.top.mas_equalTo(self.image.mas_bottom);
        make.bottom.mas_equalTo(self);
    }];
    
    [self.oneDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat width = (self.frame.size.width - 70)/5*3;
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self.image.mas_right);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(20);
    }];
    [self.one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oneDescribe.mas_bottom);
        make.left.mas_equalTo(self.oneDescribe);
        make.width.mas_equalTo(self.oneDescribe);
        make.bottom.mas_equalTo(self);
    }];

    
    [self.raw1 mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat width = (self.frame.size.width - 70)/5*2;
        make.left.mas_equalTo(self.oneDescribe.mas_right);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(30.0f);
        make.width.mas_equalTo(width);
    }];
    
    [self.raw2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.raw1);
        make.top.mas_equalTo(self.raw1.mas_bottom);
        make.size.mas_equalTo(self.raw1);
    }];
    
    [self.raw3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.raw1);
        make.top.mas_equalTo(self.raw2.mas_bottom);
        make.size.mas_equalTo(self.raw1);
    }];
}

- (UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]init];
    }
    return _image;
}

- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.font = [UIFont boldSystemFontOfSize:14];
        _name.textAlignment = NSTextAlignmentCenter;
        _name.text = @"名字";
        _name.textColor = FlatLimeDark;
    }
    return _name;
}

- (ImageLabel *)getImageLabel{
    ImageLabel *temp = [[ImageLabel alloc]init];
    [temp.image mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(temp);
        make.top.mas_equalTo(temp);
        make.bottom.mas_equalTo(temp);
        make.width.mas_equalTo(30);
    }];
    [temp.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(temp.image.mas_right);
        make.right.mas_equalTo(temp);
        make.top.mas_equalTo(temp);
        make.bottom.mas_equalTo(temp);
    }];
    temp.label.textAlignment = NSTextAlignmentLeft;
    temp.label.font = [UIFont systemFontOfSize:11];
    return temp;
}

- (UILabel *)getLabel{
    UILabel *temp = [[UILabel alloc]init];
    temp.layer.borderColor = FlatGreenDark.CGColor;
    temp.layer.borderWidth = 0.5;
    temp.font = [UIFont systemFontOfSize:12];
    temp.textAlignment = NSTextAlignmentLeft;
    temp.numberOfLines = 0;
    temp.lineBreakMode = NSLineBreakByCharWrapping;
    return temp;
}

- (UILabel *)getDescribLabel{
    UILabel *temp = [[UILabel alloc]init];
    temp.textColor = FlatGreenDark;
    temp.layer.borderColor = FlatGreenDark.CGColor;
    temp.layer.borderWidth = 0.5;
    temp.font = [UIFont systemFontOfSize:12];
    temp.textAlignment = NSTextAlignmentCenter;
    return temp;
}


@end
