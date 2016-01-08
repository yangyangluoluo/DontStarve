//
//  HomeModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/6.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "BaseModel.h"

@interface HomeModel : BaseModel

- (instancetype )init;

- (NSString *)getTitle:(NSUInteger)section row:(NSUInteger)row;
@end
