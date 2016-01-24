//
//  Tools+CoreDataProperties.h
//  DontStarve
//
//  Created by 李建国 on 16/1/23.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//
#import "MixNeed+CoreDataProperties.h"
#import "Tools.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tools (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *tools_id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *atk;
@property (nullable, nonatomic, retain) NSString *technology;
@property (nullable, nonatomic, retain) NSNumber *during;
@property (nullable, nonatomic, retain) NSString *mixCode;
@property (nullable, nonatomic, retain) NSString *urlStr;
@property (nullable, nonatomic, retain) NSSet<MixNeed *> *relationship;

@end

@interface Tools (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(MixNeed *)value;
- (void)removeRelationshipObject:(MixNeed *)value;
- (void)addRelationship:(NSSet<MixNeed *> *)values;
- (void)removeRelationship:(NSSet<MixNeed *> *)values;

@end

NS_ASSUME_NONNULL_END
