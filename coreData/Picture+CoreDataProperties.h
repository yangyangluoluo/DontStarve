//
//  Picture+CoreDataProperties.h
//  饥荒大事件
//
//  Created by 李建国 on 16/2/3.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Picture.h"

NS_ASSUME_NONNULL_BEGIN

@interface Picture (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *commentNum;
@property (nullable, nonatomic, retain) NSNumber *date;
@property (nullable, nonatomic, retain) NSNumber *picture_id;
@property (nullable, nonatomic, retain) NSNumber *pictureNum;
@property (nullable, nonatomic, retain) NSString *theDescribe;
@property (nullable, nonatomic, retain) NSString *urlStr;
@property (nullable, nonatomic, retain) NSString *user_name;
@property (nullable, nonatomic, retain) NSString *dateStr;
@property (nullable, nonatomic, retain) NSOrderedSet<PictureUrl *> *relationship;

@end

@interface Picture (CoreDataGeneratedAccessors)

- (void)insertObject:(PictureUrl *)value inRelationshipAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRelationshipAtIndex:(NSUInteger)idx;
- (void)insertRelationship:(NSArray<PictureUrl *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRelationshipAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRelationshipAtIndex:(NSUInteger)idx withObject:(PictureUrl *)value;
- (void)replaceRelationshipAtIndexes:(NSIndexSet *)indexes withRelationship:(NSArray<PictureUrl *> *)values;
- (void)addRelationshipObject:(PictureUrl *)value;
- (void)removeRelationshipObject:(PictureUrl *)value;
- (void)addRelationship:(NSOrderedSet<PictureUrl *> *)values;
- (void)removeRelationship:(NSOrderedSet<PictureUrl *> *)values;

@end

NS_ASSUME_NONNULL_END
