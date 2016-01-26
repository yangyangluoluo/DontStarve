//
//  RefineCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/25.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "RefineCell.h"

@implementation RefineCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.twoDescribe.text = @"堆叠数目";
    }
    return self;
}


@end
