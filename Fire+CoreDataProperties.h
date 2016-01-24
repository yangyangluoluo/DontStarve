//
//  Fire+CoreDataProperties.h
//  DontStarve
//
//  Created by 李建国 on 16/1/24.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Fire.h"

NS_ASSUME_NONNULL_BEGIN

@interface Fire (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *fire_id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *technology;
@property (nullable, nonatomic, retain) NSString *time;
@property (nullable, nonatomic, retain) NSString *maxTime;
@property (nullable, nonatomic, retain) NSString *code;
@property (nullable, nonatomic, retain) NSString *urlStr;
@property (nullable, nonatomic, retain) NSSet<MixNeed *> *relationship;

@end

@interface Fire (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(MixNeed *)value;
- (void)removeRelationshipObject:(MixNeed *)value;
- (void)addRelationship:(NSSet<MixNeed *> *)values;
- (void)removeRelationship:(NSSet<MixNeed *> *)values;

@end

NS_ASSUME_NONNULL_END
