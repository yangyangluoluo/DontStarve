//
//  Manager.h
//  DontStarve
//
//  Created by 李建国 on 16/1/5.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface Manager : NSObject<NSFetchedResultsControllerDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong,nonatomic) NSFetchedResultsController *fetchResultController;
@property (strong,nonatomic) NSNumber *reload;
@property (strong,nonatomic) NSNumber *update;


- (instancetype)init;
+ (Manager *)sharedManager;
- (void  )saveContext;
- (NSURL*)applicationDocumentsDirectory;
- (void  )deleteCache;
- (void  )deleteSqlite;
- (void )initFecthResultByName:(NSString *)entityName  attribute:(NSString *)entityAttribute;
- (BOOL )entityExist:(NSString *)entityName  attribute:(NSString *)entityAttribute entityId:(NSNumber *)entityId;
- (void )setDeletegate;
- (void )initFetchResultByRequest:(NSFetchRequest *)request;

@end
