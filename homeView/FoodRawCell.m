//
//  FoodRawCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/15.
//  Copyright © 2016年 李建国. All rights reserved.
//


#import "FoodRawCell.h"

@implementation FoodRawCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void)addViews{
    [self addSubview:[self image]];
    [self addSubview:[self chName]];
    [self addSubview:[self edibleMethod]];
    self.life = [self getImageLabel];
    self.life.image.image = [UIImage imageNamed:@"life.jpg"];
    [self addSubview:[self life]];
    self.hunger = [self getImageLabel];
    self.hunger.image.image = [UIImage imageNamed:@"hungry.jpg"];
    [self addSubview:[self hunger]];
    self.sanity = [self getImageLabel];
    self.sanity.image.image = [UIImage imageNamed:@"sanity.jpg"];
    [self addSubview:[self sanity]];
    self.badCycle = [self getImageLabel];
    self.badCycle.image.image = [UIImage imageNamed:@"Rot.png"];
    [self addSubview:[self badCycle]];
}

- (void)defineLayout{
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(65.0f, 65.0f));
    }];
    
    [self.chName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).offset(32.5);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    [self.edibleMethod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.chName);
        make.right.mas_equalTo(self.hunger.mas_right);
    }];
    
    [self.life mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_centerX).offset(32.5);
        make.top.mas_equalTo(self.chName.mas_bottom).offset(2);
        CGFloat width = (self.frame.size.width - 100)/2;
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(20);
    }];
    
    [self.hunger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_centerX).offset(34.5);
        make.top.mas_equalTo(self.life);
        make.size.mas_equalTo(self.life);
    }];
    
    [self.sanity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.life);
        make.top.mas_equalTo(self.life.mas_bottom).offset(2);
        make.size.mas_equalTo(self.life);
    }];
    
    [self.badCycle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sanity.mas_right).offset(2);
        make.top.mas_equalTo(self.sanity);
        make.size.mas_equalTo(self.life);
    }];
    
}

- (UIImageView *)image{
    if (!_image) {
        _image = [[UIImageView alloc]init];
    }
    return _image;
}

- (UILabel *)chName{
    if (!_chName) {
        _chName = [[UILabel alloc]init];
        _chName.textAlignment = NSTextAlignmentCenter;
        _chName.font = [UIFont systemFontOfSize:16];
        _chName.text = @"名字";
        _chName.textColor = FlatGreenDark;
    }
    return  _chName;
}

- (UILabel *)edibleMethod{
    if (!_edibleMethod) {
        _edibleMethod = [[UILabel alloc]init];
        _edibleMethod.font = [UIFont systemFontOfSize:12];
        _edibleMethod.textAlignment = NSTextAlignmentCenter;
        _edibleMethod.textColor = FlatRedDark;
    }
    return _edibleMethod;
}

- (UIView *)getLine{
    UIView *line= [[UIView alloc]init];
    line.backgroundColor = FlatGreenDark;
    return line;
}

- (ImageLabel *)getImageLabel{
    CGRect frame = CGRectMake(0,0,0,20);
    ImageLabel *imageLabel = [[ImageLabel alloc]initWithFrame:frame];
    imageLabel.layer.borderColor = FlatGreenDark.CGColor;
    imageLabel.layer.borderWidth = 0.5;
    return imageLabel;
}
@end
