//
//  Manager.h
//  DontStarve
//
//  Created by 李建国 on 16/1/5.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface Manager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (instancetype)init;
+ (Manager *)sharedManager;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void )deleteCache;
- (void )deleteSqlite;

@end
