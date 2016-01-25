//
//  RecipeDetail+CoreDataProperties.h
//  DontStarve
//
//  Created by 李建国 on 16/1/25.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RecipeDetail.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecipeDetail (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *raw1;
@property (nullable, nonatomic, retain) NSString *raw1UrlStr;
@property (nullable, nonatomic, retain) NSString *raw2;
@property (nullable, nonatomic, retain) NSString *raw2UrlStr;
@property (nullable, nonatomic, retain) NSString *raw3;
@property (nullable, nonatomic, retain) NSString *raw3UrlStr;
@property (nullable, nonatomic, retain) NSString *raw4;
@property (nullable, nonatomic, retain) NSString *raw4UrlStr;
@property (nullable, nonatomic, retain) NSNumber *recipeDetail_id;
@property (nullable, nonatomic, retain) NSString *recipeName;

@end

NS_ASSUME_NONNULL_END
