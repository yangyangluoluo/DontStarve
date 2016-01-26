//
//  Animal+CoreDataProperties.h
//  DontStarve
//
//  Created by 李建国 on 16/1/26.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Animal.h"

NS_ASSUME_NONNULL_BEGIN

@interface Animal (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *animal_id;
@property (nullable, nonatomic, retain) NSString *atk;
@property (nullable, nonatomic, retain) NSString *atkPeriod;
@property (nullable, nonatomic, retain) NSString *atktype;
@property (nullable, nonatomic, retain) NSString *attractFood;
@property (nullable, nonatomic, retain) NSString *bornRegion;
@property (nullable, nonatomic, retain) NSString *chName;
@property (nullable, nonatomic, retain) NSString *enName;
@property (nullable, nonatomic, retain) NSString *life;
@property (nullable, nonatomic, retain) NSString *loot;
@property (nullable, nonatomic, retain) NSString *remark;
@property (nullable, nonatomic, retain) NSString *runSpeed;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSString *urlStr;
@property (nullable, nonatomic, retain) NSString *walkingSpeed;
@property (nullable, nonatomic, retain) NSString *wit;

@end

NS_ASSUME_NONNULL_END