//
//  WebData.h
//  DontStarve
//
//  Created by 李建国 on 16/1/5.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "ReactiveCocoa.h"
#import "AFNetworking.h"
#import "AFURLSessionManager.h"
#import <Foundation/Foundation.h>

@interface WebData : NSObject

@property (strong,nonatomic) AFURLSessionManager *manager;
@property (strong,nonatomic) AFHTTPRequestOperationManager *filemanager;
@property (strong,nonatomic) NSURLSessionConfiguration *configuration;
@property (strong,nonatomic) __block NSArray  *allCharacters;
@property (strong,nonatomic) __block NSArray  *allAnimal;
@property (strong,nonatomic) __block NSArray  *allPlant;
@property (strong,nonatomic) __block NSArray   *allConstruction;

- (instancetype)init;
+ (WebData *)sharedManager;
- (void )downLoadCharactersbyId:(NSNumber *)CharactersId;
- (void )downloadAnimal:(NSNumber *)animalId;
- (void )downloadAllPlant:(NSNumber *)plantId;
- (void )downloadConstruction:(NSNumber *)constructionId;

@end
