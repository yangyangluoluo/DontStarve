//
//  Characters+CoreDataProperties.h
//  DontStarve
//
//  Created by 李建国 on 16/1/26.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Characters.h"

NS_ASSUME_NONNULL_BEGIN

@interface Characters (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *ability;
@property (nullable, nonatomic, retain) NSString *atk;
@property (nullable, nonatomic, retain) NSNumber *characters_id;
@property (nullable, nonatomic, retain) NSString *hungry;
@property (nullable, nonatomic, retain) NSString *intellect;
@property (nullable, nonatomic, retain) NSString *introduction;
@property (nullable, nonatomic, retain) NSString *life;
@property (nullable, nonatomic, retain) NSString *motto;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *nickname;
@property (nullable, nonatomic, retain) NSString *unlock;
@property (nullable, nonatomic, retain) NSString *urlstr;

@end

NS_ASSUME_NONNULL_END
