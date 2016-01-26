//
//  DressCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/26.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "DressCell.h"

@implementation DressCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        self.one.textColor = FlatRedDark;
        self.four.font = [UIFont systemFontOfSize:12];
        self.four.numberOfLines = 0;
        self.four.lineBreakMode = NSLineBreakByCharWrapping;
        
        self.oneDescribe.text =   @"需要科技";
        self.twoDescribe.text =   @"耐   久";
        self.threeDescribe.text = @"合成代码";
        self.fourDescribe.text =  @"功   能";
        
        self.raw1.layer.borderColor = FlatGreenDark.CGColor;
        self.raw1.layer.borderWidth = 0.5;
        self.raw2.layer.borderColor = FlatGreenDark.CGColor;
        self.raw2.layer.borderWidth = 0.5;
        self.raw3.layer.borderColor = FlatGreenDark.CGColor;
        self.raw3.layer.borderWidth = 0.5;

        
        [self.oneDescribe mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.image.mas_right);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(50);
        }];
        [self.one mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.oneDescribe.mas_right);
            make.top.mas_equalTo(self);
            make.right.mas_equalTo(self.raw1.mas_left);
            make.height.mas_equalTo(20);
        }];
        
        [self.twoDescribe mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.oneDescribe);
            make.top.mas_equalTo(self.oneDescribe.mas_bottom);
            make.size.mas_equalTo(self.oneDescribe);
        }];
        [self.two mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.one);
            make.top.mas_equalTo(self.one.mas_bottom);
            make.size.mas_equalTo(self.one);
        }];
        
        [self.threeDescribe mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.oneDescribe);
            make.top.mas_equalTo(self.twoDescribe.mas_bottom);
            make.size.mas_equalTo(self.oneDescribe);
        }];
        [self.three mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.one);
            make.top.mas_equalTo(self.two.mas_bottom);
            make.size.mas_equalTo(self.one);
        }];
        
        [self.fourDescribe mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.oneDescribe);
            make.top.mas_equalTo(self.threeDescribe.mas_bottom);
            make.width.mas_equalTo(self.oneDescribe);
            make.height.mas_equalTo(40);
        }];
        [self.four mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.one);
            make.top.mas_equalTo(self.three.mas_bottom);
            make.width.mas_equalTo(self.one);
            make.height.mas_equalTo(40);
        }];
        
        [self.raw1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(33);
            CGFloat width = (self.frame.size.width - 60)/3;
            make.width.mas_equalTo(width);
        }];
    }
    return self;
}

@end
