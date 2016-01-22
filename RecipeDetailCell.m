//
//  RecipeDetailCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/22.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "RecipeDetailCell.h"

@implementation RecipeDetailCell

- (instancetype )initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void)addViews{
    self.raw1 = [self getImageLabel];
    [self addSubview:[self raw1]];
    self.raw2 = [self getImageLabel];
    [self addSubview:[self raw2]];
    self.raw3 = [self getImageLabel];
    [self addSubview:[self raw3]];
    self.raw4 = [self getImageLabel];
    [self addSubview:[self raw4]];

}

- (void)defineLayout{
    [self.raw1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(self.frame.size.height-20);
        make.bottom.mas_equalTo(self);
    }];
    
    [self.raw2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.raw1.mas_right);
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(self.raw1);
    }];
    
    [self.raw3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.raw2.mas_right);
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(self.raw1);
    }];
    
    [self.raw4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.raw3.mas_right);
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(self.raw1);
    }];
}

- (ImageLabel *)getImageLabel{
    ImageLabel *imageLabel = [[ImageLabel alloc]init];
    [imageLabel.image mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageLabel);
        make.top.mas_equalTo(imageLabel);
        make.width.mas_equalTo(self.frame.size.height-20);
        make.height.mas_equalTo(self.frame.size.height-20);
    }];
    [imageLabel.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageLabel.image.mas_bottom);
        make.left.mas_equalTo(imageLabel.image.mas_left);
        make.right.mas_equalTo(imageLabel.image.mas_right);
        make.bottom.mas_equalTo(imageLabel);
    }];
    imageLabel.layer.borderWidth = 0.5;
    imageLabel.layer.borderColor = FlatGreen.CGColor;
    return imageLabel;
    
}


@end
