//
//  RecipeDetailHeaderCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/22.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "RecipeDetailHeaderCell.h"

@implementation RecipeDetailHeaderCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.needRawArray = [[NSMutableArray alloc]init];
        self.needNotRawArray = [[NSMutableArray alloc]init];
        [self addViewRecipeCell];
        [self redefineLayoutRecipeCell];
    }
    return self;
}

- (void)addViewRecipeCell{
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:[self bgView]];
    [self sendSubviewToBack:self.bgView];
    [self addSubview:[self needRaw]];
    [self addSubview:[self needNotRaw]];
}

- (void)redefineLayoutRecipeCell{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(160);
    }];
    
    [self.image mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView);
        make.bottom.mas_equalTo(self.badCycle);
        make.size.mas_equalTo(CGSizeMake(65.0f, 65.0f));
    }];
    
    [self.chName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.image.mas_right).offset(5);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-5);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(25);
    }];
    
    [self.life mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGFloat width = (self.frame.size.width - 85-40)/3;
        make.left.mas_equalTo(self.image.mas_right).offset(5);
        make.top.mas_equalTo(self.chName.mas_bottom);
        make.height.mas_equalTo(30);
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
    
    [self.cookTime mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.hunger);
        make.top.mas_equalTo(self.badCycle);
        make.size.mas_equalTo(self.life);
    }];
    
    [self.priority mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sanity);
        make.top.mas_equalTo(self.badCycle);
        make.size.mas_equalTo(self.life);
    }];
    
    [self.needRaw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.life);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.badCycle.mas_bottom).offset(5);
        make.left.mas_equalTo(self.bgView);
    }];
    
    [self.needNotRaw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.needRaw);
        make.top.mas_equalTo(self.needRaw.mas_bottom).offset(5);
        make.left.mas_equalTo(self.bgView);
    }];
}


- (UILabel *)needRaw{
    if (!_needRaw) {
        _needRaw = [[UILabel alloc]init];
        _needRaw.backgroundColor = FlatGreenDark;
        _needRaw.text = @"需要材料";
        _needRaw.textAlignment = NSTextAlignmentCenter;
        _needRaw.font = [UIFont systemFontOfSize:14];
    }
    return _needRaw;
}

- (UILabel *)needNotRaw{
    if (!_needNotRaw) {
        _needNotRaw = [[UILabel alloc]init];
        _needNotRaw.layer.backgroundColor = FlatRedDark.CGColor;
        _needNotRaw.text = @"禁止材料";
        _needNotRaw.textAlignment = NSTextAlignmentCenter;
        _needNotRaw.font = [UIFont systemFontOfSize:14];
    }
    return _needNotRaw;
}


- (void )initNeedRawLabel:(NSUInteger )num{
    if (self.needRawArray.count == 0) {
        for (int index=0; index<num; index++) {
            ImageLabel *temp = [self getImageLabel1];
            temp.label.font = [UIFont boldSystemFontOfSize:12];
            temp.layer.backgroundColor = FlatGreenDark.CGColor;
            [self.needRawArray addObject:temp];
            [self addSubview:temp];
        }
        [self defineAllLayout];
    }
}

- (void )initNeedNotRawLabel:(NSUInteger )num{
    if (self.needNotRawArray.count == 0) {
        for (int index=0; index<num; index++) {
            ImageLabel *temp = [self getImageLabel1];
            temp.label.font = [UIFont boldSystemFontOfSize:12];
            temp.layer.backgroundColor = FlatRed.CGColor;
            [self.needNotRawArray addObject:temp];
            [self addSubview:temp];
        }
    }
}

- (void )defineAllLayout{
    for (int index = 0; index<self.needRawArray.count; index++) {
        ImageLabel *temp = self.needRawArray[index];
        [temp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.needRaw);
            make.top.mas_equalTo(self.needRaw);
            CGFloat width = ((self.frame.size.width - 85-40)/3+5)*(index+1);
            make.left.mas_equalTo(self.bgView).offset(width);
        }];
    }
    
    for (int index = 0; index<self.needNotRawArray.count; index++) {
        ImageLabel *temp = self.needNotRawArray[index];
        [temp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.needRaw);
            make.top.mas_equalTo(self.needNotRaw);
            CGFloat width = ((self.frame.size.width - 85-40)/3+5)*(index+1);
            make.left.mas_equalTo(self.bgView).offset(width);
        }];
    }
}

- (ImageLabel *)getImageLabel1{
    CGRect frame = CGRectMake(0,0,0,30);
    ImageLabel *imageLabel = [[ImageLabel alloc]initWithFrame:frame];
    [imageLabel.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageLabel.image.mas_right);
        make.top.mas_equalTo(imageLabel);
        make.bottom.mas_equalTo(imageLabel);
    }];
    return imageLabel;
}


@end
