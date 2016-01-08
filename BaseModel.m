//
//  baseModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/5.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BaseModel.h"
@interface BaseModel ()
@end

@implementation BaseModel

- (instancetype )init{
    self = [super init];
    if (self) {
        self.manager = [Manager sharedManager];
        self.webData = [WebData sharedManager];
    }
    return self;
}

@end
