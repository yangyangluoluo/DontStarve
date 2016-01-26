//
//  FoodRawModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/15.
//  Copyright © 2016年 李建国. All rights reserved.
//
@class FoodRaw;
#import "BaseModel.h"

@interface FoodRawModel : BaseModel

- (FoodRaw *)getFoodRaw:(NSUInteger)row;

@end
