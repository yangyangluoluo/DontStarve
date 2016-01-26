//
//  RecipeModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/17.
//  Copyright © 2016年 李建国. All rights reserved.
//
@class Recipe;
#import "BaseModel.h"

@interface RecipeModel : BaseModel

- (Recipe *)getRecipe:(NSUInteger)row;

@end
