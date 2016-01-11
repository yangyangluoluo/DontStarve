//
//  Construction+CoreDataProperties.h
//  DontStarve
//
//  Created by 李建国 on 16/1/11.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Construction.h"

NS_ASSUME_NONNULL_BEGIN

@interface Construction (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *construction_id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *describe;
@property (nullable, nonatomic, retain) NSString *produce;
@property (nullable, nonatomic, retain) NSString *urlStr;

@end

NS_ASSUME_NONNULL_END
