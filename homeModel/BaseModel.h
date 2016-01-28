//
//  baseModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/5.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Manager.h"
#import "WebData.h"
#import "User.h"
#import <Foundation/Foundation.h>
#import "CellProtocol.h"
#import "DefineState.h"
@interface BaseModel : NSObject<NSFetchedResultsControllerDelegate,CellProtocol>

#define PREFIX  @"http://192.168.1.220/"
@property (strong,nonatomic) NSArray *allData;
@property (strong,nonatomic) NSNumber *reload;
@property (strong,nonatomic) NSNumber *update;
@property (strong,nonatomic) NSFetchedResultsController *fetchResultController;
@property (strong,nonatomic) Manager *manager;
@property (strong,nonatomic) WebData *webData;
@property (strong,nonatomic) User *theUser;

- (instancetype)init;
- (NSString *)getName;
- (NSNumber *)getRank;
- (id )getObjetc:(NSUInteger )row;
- (void )saveName:(NSString *)name rank:(NSNumber *)rank;
- (NSUInteger )getDate:(NSString *)entityname name:(NSString *)idName direction:(NSString *)direction;
@end
