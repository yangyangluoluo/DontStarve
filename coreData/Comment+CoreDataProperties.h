//
//  Comment+CoreDataProperties.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/30.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Comment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Comment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *comment_id;
@property (nullable, nonatomic, retain) NSString *user_name;
@property (nullable, nonatomic, retain) NSString *urlStr;
@property (nullable, nonatomic, retain) NSNumber *date;
@property (nullable, nonatomic, retain) NSString *theDescribe;
@property (nullable, nonatomic, retain) NSNumber *primary_id;
@property (nullable, nonatomic, retain) NSString *tableName;
@property (nullable, nonatomic, retain) NSString *dateStr;

@end

NS_ASSUME_NONNULL_END
