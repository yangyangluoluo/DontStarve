//
//  Boss+CoreDataProperties.h
//  DontStarve
//
//  Created by 李建国 on 16/1/25.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Boss.h"

NS_ASSUME_NONNULL_BEGIN

@interface Boss (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *atk;
@property (nullable, nonatomic, retain) NSString *atkPeriod;
@property (nullable, nonatomic, retain) NSString *atkRange;
@property (nullable, nonatomic, retain) NSString *bornRegion;
@property (nullable, nonatomic, retain) NSNumber *boss_Id;
@property (nullable, nonatomic, retain) NSString *bossType;
@property (nullable, nonatomic, retain) NSString *chName;
@property (nullable, nonatomic, retain) NSString *enName;
@property (nullable, nonatomic, retain) NSString *life;
@property (nullable, nonatomic, retain) NSString *loot;
@property (nullable, nonatomic, retain) NSString *moveSpeed;
@property (nullable, nonatomic, retain) NSString *sanityEffect;
@property (nullable, nonatomic, retain) NSString *specialAbility;
@property (nullable, nonatomic, retain) NSString *urlStr;

@end

NS_ASSUME_NONNULL_END
