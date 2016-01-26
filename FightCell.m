//
//  FightCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/26.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "FightCell.h"

@implementation FightCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.twoDescribe.text =   @"攻击防御";
        self.two.font = [UIFont systemFontOfSize:12];
        self.threeDescribe.text = @"耐   久";
        self.three.font = [UIFont systemFontOfSize:12];
        self.four.font = [UIFont systemFontOfSize:12];
        self.fiveDescribe.text =  @"特   殊";
    }
    return self;
}

@end
