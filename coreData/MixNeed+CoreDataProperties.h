//
//  MixNeed+CoreDataProperties.h
//  DontStarve
//
//  Created by 李建国 on 16/1/26.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//
#import "CoreDataHeader.h"
#import "MixNeed.h"

NS_ASSUME_NONNULL_BEGIN

@interface MixNeed (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *mixNeed_id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *num;
@property (nullable, nonatomic, retain) NSString *urlStr;
@property (nullable, nonatomic, retain) Fire *relationship1;
@property (nullable, nonatomic, retain) Science *relationship2;
@property (nullable, nonatomic, retain) Refine *relationship3;
@property (nullable, nonatomic, retain) Produce *relationship4;
@property (nullable, nonatomic, retain) Build *relationship5;
@property (nullable, nonatomic, retain) Tools *relationship6;
@property (nullable, nonatomic, retain) Magic *relationship;
@property (nullable, nonatomic, retain) Ancient *relationship7;
@property (nullable, nonatomic, retain) Book *relationship8;
@property (nullable, nonatomic, retain) Dress *relationship9;
@property (nullable, nonatomic, retain) Fight *relationship10;
@property (nullable, nonatomic, retain) Survival *relationship11;

@end

NS_ASSUME_NONNULL_END
