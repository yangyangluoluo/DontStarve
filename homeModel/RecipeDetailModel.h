//
//  RecipeDetailModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/21.
//  Copyright © 2016年 李建国. All rights reserved.
//
@class RecipeDetail;
#import "RecipeRaw+CoreDataProperties.h"
#import "BaseModel.h"

@interface RecipeDetailModel : BaseModel

@property (strong,nonatomic) NSArray *recipeRaw;
@property (strong,nonatomic) NSFetchedResultsController *fetchRecipeRaw;

- (instancetype )initWithRecipe:(NSNumber *)recipeId andName:(NSString *)recipeName;
- (void )saveRecipeRawToCoreData;
- (NSUInteger )getNeedRawNum;
- (NSUInteger )getNeedNotRawNum;
- (RecipeRaw *)getRecipeRaw:(NSUInteger)section andRow:(NSUInteger)row;
- (RecipeDetail *)getDetail:(NSUInteger)row;
@end
