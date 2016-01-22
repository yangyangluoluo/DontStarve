//
//  RecipeCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/17.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Masonry.h"
#import "RecipeCell.h"

@implementation RecipeCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self addMoreView];
        [self redefineLayout];
    }
    return self;
}

- (void)addMoreView{
    self.edibleMethod = nil;
    self.cookTime = [self getImageLabel];
    self.cookTime.image.image = [UIImage imageNamed:@"Pot.png"];
    [self addSubview:[self cookTime]];
    [self addSubview:[self priority]];
}

- (void)redefineLayout{
    [self.image mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(7.5f);
        make.size.mas_equalTo(CGSizeMake(65.0f, 65.0f));
    }];
    
    [self.chName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.image.mas_right).offset(5);
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(25);
    }];
    
    [self.life mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGFloat width = (self.frame.size.width - 85)/3;
        make.left.mas_equalTo(self.image.mas_right).offset(5);
        make.top.mas_equalTo(self.chName.mas_bottom);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(width);
    }];
    
    [self.hunger mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.life.mas_right).offset(5);
        make.top.mas_equalTo(self.life);
        make.size.mas_equalTo(self.life);
    }];
    
    [self.sanity mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hunger.mas_right).offset(5);
        make.top.mas_equalTo(self.life);
        make.size.mas_equalTo(self.life);
    }];
    
    [self.badCycle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.life);
        make.top.mas_equalTo(self.life.mas_bottom).offset(5);
        make.size.mas_equalTo(self.life);
    }];
    
    [self.cookTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hunger);
        make.top.mas_equalTo(self.badCycle);
        make.size.mas_equalTo(self.life);
    }];
    
    [self.priority mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sanity);
        make.top.mas_equalTo(self.badCycle);
        make.size.mas_equalTo(self.life);
    }];
}

- (UILabel *)priority{
    if (!_priority) {
        _priority = [[UILabel alloc]init];
        _priority.layer.borderColor = FlatGreenDark.CGColor;
        _priority.layer.borderWidth = 0.5;
        _priority.textAlignment = NSTextAlignmentLeft;
        _priority.font = [UIFont systemFontOfSize:12];
        _priority.text = @"优先权";
    }
    return _priority;
}

@end
