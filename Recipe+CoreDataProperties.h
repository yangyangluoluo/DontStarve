//
//  Recipe+CoreDataProperties.h
//  DontStarve
//
//  Created by 李建国 on 16/1/21.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//
#import "RecipeRaw+CoreDataProperties.h"
#import "Recipe.h"

NS_ASSUME_NONNULL_BEGIN

@interface Recipe (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *badCycle;
@property (nullable, nonatomic, retain) NSString *chName;
@property (nullable, nonatomic, retain) NSNumber *cookTime;
@property (nullable, nonatomic, retain) NSString *enName;
@property (nullable, nonatomic, retain) NSNumber *hunger;
@property (nullable, nonatomic, retain) NSNumber *life;
@property (nullable, nonatomic, retain) NSNumber *priority;
@property (nullable, nonatomic, retain) NSNumber *recipe_id;
@property (nullable, nonatomic, retain) NSNumber *sanity;
@property (nullable, nonatomic, retain) NSString *urlStr;
@property (nullable, nonatomic, retain) NSSet<RecipeRaw *> *theRaw;

@end

@interface Recipe (CoreDataGeneratedAccessors)

- (void)addTheRawObject:(RecipeRaw *)value;
- (void)removeTheRawObject:(RecipeRaw *)value;
- (void)addTheRaw:(NSSet<RecipeRaw *> *)values;
- (void)removeTheRaw:(NSSet<RecipeRaw *> *)values;

@end

NS_ASSUME_NONNULL_END
