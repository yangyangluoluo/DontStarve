//
//  ConstructionCell.m
//  DontStarve
//
//  Created by 李建国 on 16/1/11.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "ConstructionCell.h"

@implementation ConstructionCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self reloadLayout1];
    }
    return self;
}

- (void)reloadLayout1 {
    self.enName.textAlignment = NSTextAlignmentLeft;
    self.type.textAlignment = NSTextAlignmentLeft;
}

@end
