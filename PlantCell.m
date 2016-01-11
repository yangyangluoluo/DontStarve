//
//  PlantCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/10.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "PlantCell.h"

@implementation PlantCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self reloadLayout];
    }
    return self;
}

- (void)reloadLayout {
    self.chName.font = [UIFont systemFontOfSize:16];
    self.chName.textAlignment = NSTextAlignmentCenter;
    self.enName.font = [UIFont systemFontOfSize:12];
    self.enName.textAlignment = NSTextAlignmentCenter;
    self.enName.numberOfLines = 0;
    self.enName.lineBreakMode = NSLineBreakByCharWrapping;
    self.type.font = [UIFont systemFontOfSize:12];
    self.type.textAlignment = NSTextAlignmentCenter;
    self.type.numberOfLines = 0;
    self.type.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self.image mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(5);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.chName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(self.image.mas_right).offset(10);
        make.right.mas_equalTo(self).offset(-10);
    }];
    
    [self.line1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.image.mas_right).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self.chName.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.enName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.right.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.line1.mas_bottom);
        make.height.mas_equalTo(50);
    }];

    [self.line2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.enName.mas_bottom);
        make.size.mas_equalTo(self.line1);
    }];
    
    [self.type mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.right.mas_equalTo(self.line1);
        make.top.mas_equalTo(self.line2.mas_bottom);
        make.height.mas_equalTo(50);
    }];

    [self.line3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.bottom.mas_equalTo(self).offset(-0.5);
        make.size.mas_equalTo(self.line1);
    }];
    

    

}



@end
