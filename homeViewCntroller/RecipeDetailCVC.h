//
//  RecipeDetailCVC.h
//  DontStarve
//
//  Created by 李建国 on 16/1/21.
//  Copyright © 2016年 李建国. All rights reserved.
//
@class Recipe;
#import "BaseCVC.h"

@interface RecipeDetailCVC : BaseCVC

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout recipe:(Recipe *)theRecipe;

@end
