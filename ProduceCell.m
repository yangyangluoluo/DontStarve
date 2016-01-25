//
//  ProduceCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/24.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "ProduceCell.h"

@implementation ProduceCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.oneDescribe.text = @"需要科技";
        self.twoDescribe.text = @"功能作用";
        self.threeDescribe.text = @"合成代码";
        self.three.font = [UIFont systemFontOfSize:10];
        [self.two mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.twoDescribe);
            make.top.mas_equalTo(self.twoDescribe.mas_bottom);
            make.bottom.mas_equalTo(self);
            make.right.mas_equalTo(self.twoDescribe);
        }];
        [self.fourDescribe mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
        [self.four mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    return self;
}

@end
