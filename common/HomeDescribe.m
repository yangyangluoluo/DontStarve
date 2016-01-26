//
//  HomeDescribe.m
//  DontStarve
//
//  Created by 李建国 on 16/1/22.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "HomeDescribe.h"

@implementation HomeDescribe

- (instancetype)initWitchName:(NSString *)chName enName:(NSString *)enName icon:(NSString *)icon{
    self = [super init];
    if (self) {
        self.chName = chName;
        self.enName = enName;
        self.icon = icon;
    }
    return self;
}

@end
