//
//  FoodRaw+CoreDataProperties.h
//  DontStarve
//
//  Created by 李建国 on 16/1/25.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FoodRaw.h"

NS_ASSUME_NONNULL_BEGIN

@interface FoodRaw (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *badCycle;
@property (nullable, nonatomic, retain) NSString *chName;
@property (nullable, nonatomic, retain) NSString *edibleMethod;
@property (nullable, nonatomic, retain) NSString *enName;
@property (nullable, nonatomic, retain) NSNumber *foodRaw_id;
@property (nullable, nonatomic, retain) NSNumber *hunger;
@property (nullable, nonatomic, retain) NSNumber *life;
@property (nullable, nonatomic, retain) NSNumber *sanity;
@property (nullable, nonatomic, retain) NSString *urlStr;

@end

NS_ASSUME_NONNULL_END
