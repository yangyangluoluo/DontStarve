//
//  RecipeRaw+CoreDataProperties.h
//  DontStarve
//
//  Created by 李建国 on 16/1/25.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RecipeRaw.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecipeRaw (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *needNum;
@property (nullable, nonatomic, retain) NSNumber *needtype;
@property (nullable, nonatomic, retain) NSNumber *recipe_id;
@property (nullable, nonatomic, retain) NSNumber *recipeRaw_id;
@property (nullable, nonatomic, retain) NSString *urlStr;

@end

NS_ASSUME_NONNULL_END
