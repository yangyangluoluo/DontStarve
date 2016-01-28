//
//  QuestionComment+CoreDataProperties.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/28.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "QuestionComment.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuestionComment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *questionComment_id;
@property (nullable, nonatomic, retain) NSNumber *question_id;
@property (nullable, nonatomic, retain) NSString *user_name;
@property (nullable, nonatomic, retain) NSString *theDescribe;
@property (nullable, nonatomic, retain) NSNumber *date;
@property (nullable, nonatomic, retain) NSString *urlStr;
@property (nullable, nonatomic, retain) NSString *dateStr;

@end

NS_ASSUME_NONNULL_END
