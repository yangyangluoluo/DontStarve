//
//  HomeModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/6.
//  Copyright © 2016年 李建国. All rights reserved.
//
@class HomeDescribe;
#import "BaseModel.h"

@interface HomeModel : BaseModel

- (instancetype )init;

- (HomeDescribe *)getDescribe:(NSUInteger)section row:(NSUInteger)row;
- (NSUInteger )getCount;
- (NSUInteger )getSectionCount:(NSUInteger)section;
@end
