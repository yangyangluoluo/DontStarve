//
//  ToolCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/23.
//  Copyright © 2016年 李建国. All rights reserved.
//


#import "ToolCell.h"

@implementation ToolCell

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
    self.oneDescribe.text = @"伤害";
    [self addSubview:[self oneDescribe]];
    self.one = [self getLabel];
    [self addSubview:[self one]];
    
    self.twoDescribe = [self getDescribLabel];
    self.twoDescribe.text = @"需要科技";
    [self addSubview:[self twoDescribe]];
    self.two = [self getLabel];
    [self addSubview:[self two]];
    
    self.threeDescribe = [self getDescribLabel];
    self.threeDescribe.text = @"耐久度";
    [self addSubview:[self threeDescribe]];
    self.three = [self getLabel];
    [self addSubview:[self three]];
    
    self.fourDescribe = [self getDescribLabel];
    self.fourDescribe.text = @"合成代码";
    [self addSubview:[self fourDescribe]];
    self.four = [self getLabel];
    self.four.font = [UIFont systemFontOfSize:10];
    [self addSubview:[self four]];
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
        CGFloat width = (self.frame.size.width - 70)/4;
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self.image.mas_right);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(20);
    }];
    [self.one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oneDescribe.mas_bottom);
        make.left.mas_equalTo(self.oneDescribe);
        make.width.mas_equalTo(self.oneDescribe);
        make.height.mas_equalTo(25);
    }];
    
    [self.twoDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.oneDescribe.mas_right);
        make.top.mas_equalTo(self.oneDescribe);
        make.size.mas_equalTo(self.oneDescribe);
    }];
    [self.two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.twoDescribe);
        make.top.mas_equalTo(self.twoDescribe.mas_bottom);
        make.size.mas_equalTo(self.one);
    }];
    
    [self.threeDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.oneDescribe);
        make.top.mas_equalTo(self.one.mas_bottom);
        make.size.mas_equalTo(self.oneDescribe);
    }];
    [self.three mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.threeDescribe);
        make.top.mas_equalTo(self.threeDescribe.mas_bottom);
        make.size.mas_equalTo(self.one);
    }];
    
    [self.fourDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.twoDescribe);
        make.top.mas_equalTo(self.two.mas_bottom);
        make.size.mas_equalTo(self.oneDescribe);
    }];
    [self.four mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.fourDescribe);
        make.top.mas_equalTo(self.fourDescribe.mas_bottom);
        make.size.mas_equalTo(self.one);
    }];
    
    [self.raw1 mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat width = (self.frame.size.width - 70)/2;
        make.left.mas_equalTo(self.twoDescribe.mas_right);
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
    return temp;
}

- (UILabel *)getLabel{
    UILabel *temp = [[UILabel alloc]init];
    temp.layer.borderColor = FlatGreenDark.CGColor;
    temp.layer.borderWidth = 0.5;
    temp.font = [UIFont systemFontOfSize:12];
    temp.textAlignment = NSTextAlignmentCenter;
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
