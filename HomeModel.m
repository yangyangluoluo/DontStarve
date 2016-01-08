//
//  HomeModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/6.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "HomeModel.h"

@interface HomeModel ()

@property (strong,nonatomic) NSMutableArray *titles;

@end

@implementation HomeModel

- (instancetype)init{
    self = [super init];
    if (self) {
        NSArray *title = @[@"饥荒人物",@"饥荒动物",@"饥荒植物",@"饥荒群落"];
        self.titles = [[NSMutableArray alloc]init];
        [self.titles addObject:title];
        [self.titles addObject:title];
        [self.titles addObject:title];
    }
    return self;
}

- (NSString *)getTitle:(NSUInteger)section row:(NSUInteger)row;{
    return self.titles[section][row];
}

@end
