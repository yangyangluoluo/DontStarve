//
//  BossTrait+CoreDataProperties.h
//  DontStarve
//
//  Created by 李建国 on 16/1/14.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BossTrait.h"

NS_ASSUME_NONNULL_BEGIN

@interface BossTrait (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *boss_id;
@property (nullable, nonatomic, retain) NSNumber *bossTrait_id;
@property (nullable, nonatomic, retain) NSString *describe;
@property (nullable, nonatomic, retain) NSNumber *type;

@end

NS_ASSUME_NONNULL_END
