//
//  baseModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/5.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "ReactiveCocoa.h"
#import "AFNetworking.h"
#import "AFURLSessionManager.h"
#import "Manager.h"
#import "WebData.h"
#import "User.h"
#import <Foundation/Foundation.h>
#import "CellProtocol.h"
#import "DefineState.h"
#import "DefineUrl.h"

@interface BaseModel : NSObject<CellProtocol>

@property (strong,nonatomic) NSArray *allData;
@property (strong,nonatomic) __block id data;
@property (strong,nonatomic) __block id data1;
@property (strong,nonatomic) NSString *entityname;
@property (strong,nonatomic) NSString *entyArr;
@property (strong,nonatomic) NSFetchedResultsController *fetchResultController;
@property (strong,nonatomic) Manager *manager;
@property (strong,nonatomic) WebData *webData;
@property (strong,nonatomic) User *theUser;
@property (strong,nonatomic) NSDateFormatter *dateFormatter;

- (instancetype)init;
- (NSString *)getName;
- (NSNumber *)getRank;
- (id )getObject:(NSUInteger )row;
- (void )saveName:(NSString *)name rank:(NSNumber *)rank;
- (NSUInteger )getDate:(NSString *)entityname name:(NSString *)idName direction:(NSString *)direction;

- (void )downloadAddress:(NSString *)address;
- (void )downloadAddress:(NSString *)address information:(NSDictionary *)information;
- (void )downloadAddress1:(NSString *)address1;
- (void )downloadAddress1:(NSString *)address1 information1:(NSDictionary *)information1;
- (void )savePictureData:(NSData *)data;
@end
