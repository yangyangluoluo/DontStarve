//
//  PictureUrl+CoreDataProperties.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/30.
//  Copyright © 2016年 李建国. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PictureUrl.h"

NS_ASSUME_NONNULL_BEGIN

@interface PictureUrl (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *pictureUrl_id;
@property (nullable, nonatomic, retain) NSNumber *picture_id;
@property (nullable, nonatomic, retain) NSString *urlStr;
@property (nullable, nonatomic, retain) Picture *relationship;

@end

NS_ASSUME_NONNULL_END
