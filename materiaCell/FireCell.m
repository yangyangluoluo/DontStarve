//
//  FireCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/24.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "FireCell.h"

@implementation FireCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.oneDescribe.text = @"需要科技";
        self.twoDescribe.text = @"持续时间";
        self.threeDescribe.text = @"最大时间";
    }
    return self;
}
@end
