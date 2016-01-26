//
//  Book+CoreDataProperties.h
//  DontStarve
//
//  Created by 李建国 on 16/1/26.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface Book (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *book_id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *describe;
@property (nullable, nonatomic, retain) NSString *urlStr;
@property (nullable, nonatomic, retain) NSOrderedSet<MixNeed *> *relationship;

@end

@interface Book (CoreDataGeneratedAccessors)

- (void)insertObject:(MixNeed *)value inRelationshipAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRelationshipAtIndex:(NSUInteger)idx;
- (void)insertRelationship:(NSArray<MixNeed *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRelationshipAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRelationshipAtIndex:(NSUInteger)idx withObject:(MixNeed *)value;
- (void)replaceRelationshipAtIndexes:(NSIndexSet *)indexes withRelationship:(NSArray<MixNeed *> *)values;
- (void)addRelationshipObject:(MixNeed *)value;
- (void)removeRelationshipObject:(MixNeed *)value;
- (void)addRelationship:(NSOrderedSet<MixNeed *> *)values;
- (void)removeRelationship:(NSOrderedSet<MixNeed *> *)values;

@end

NS_ASSUME_NONNULL_END