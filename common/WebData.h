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
@property (strong,nonatomic) AFHTTPRequestOperationManager *jsonManager;
@property (strong,nonatomic) AFHTTPRequestOperationManager *filemanager;
@property (strong,nonatomic) NSURLSessionConfiguration *configuration;

//@property (strong,nonatomic) __block NSArray  *allCharacters;
//@property (strong,nonatomic) __block NSArray  *allAnimal;
//@property (strong,nonatomic) __block NSArray  *allPlant;
//@property (strong,nonatomic) __block NSArray  *allConstruction;
//@property (strong,nonatomic) __block NSArray  *allBoss;
//@property (strong,nonatomic) __block NSArray  *bossTrait;
//@property (strong,nonatomic) __block NSArray  *allFoodRaw;
//@property (strong,nonatomic) __block NSArray  *allRecipe;
//@property (strong,nonatomic) __block NSArray  *recipeRaw;
//@property (strong,nonatomic) __block NSArray  *recipeDetail;
//@property (strong,nonatomic) __block NSArray  *allTool;
//@property (strong,nonatomic) __block NSArray  *allFire;
//@property (strong,nonatomic) __block NSArray  *allProduce;
//@property (strong,nonatomic) __block NSArray  *allScience;
//@property (strong,nonatomic) __block NSArray  *allBuild;
//@property (strong,nonatomic) __block NSArray  *allRefine;
//@property (strong,nonatomic) __block NSArray  *allMagic;
//@property (strong,nonatomic) __block NSArray  *allAncient;
//@property (strong,nonatomic) __block NSArray  *allBook;
//@property (strong,nonatomic) __block NSArray  *allSurvival;
//@property (strong,nonatomic) __block NSArray  *allFight;
//@property (strong,nonatomic) __block NSArray  *allDress;
@property (strong,nonatomic) __block NSArray  *homeData1;
@property (strong,nonatomic) __block NSArray  *homeData2;
@property (strong,nonatomic) __block NSArray  *homeData3;
@property (strong,nonatomic) __block NSDictionary  *registerState;
@property (strong,nonatomic) __block NSDictionary  *loginState;
@property (strong,nonatomic) __block NSDictionary  *addQuestionState;
@property (strong,nonatomic) __block NSArray  *allQuestion;
@property (strong,nonatomic) __block NSDictionary *commentQuestion;
@property (strong,nonatomic) __block NSArray *questionComment;
@property (strong,nonatomic) __block NSDictionary *questionReply;


- (instancetype)init;
+ (WebData *)sharedManager;
- (void )downLoadCharactersbyId:(NSNumber *)CharactersId;
- (void )downloadAnimal:(NSNumber *)animalId;
- (void )downloadAllPlant:(NSNumber *)plantId;
- (void )downloadConstruction:(NSNumber *)constructionId;
- (void )downloadBoss:(NSNumber *)bossId;
- (void )downloadBossTrait:(NSNumber *)bossId;
- (void )downloadAllFoodRaw:(NSNumber *)foodId;
- (void )downloadAllRecipe:(NSNumber *)recipeId;
- (void )downloadRecipeRaw:(NSNumber *)recipeId;
- (void )downloadRecipeDetail:(NSString *)recipeName;
- (void )downloadAllTool:(NSNumber *)toolId;
- (void )downloadAllFire:(NSNumber *)fireId;
- (void )downloadAllProduce:(NSNumber *)produceId;
- (void )downloadAllScience:(NSNumber *)sicenceId;
- (void )downloadAllBuild:(NSNumber *)BuildId;
- (void )downloadAllRefine:(NSNumber *)refineId;
- (void )downloadAllMagic:(NSNumber *)magicId;
- (void )downloadAllAncient:(NSNumber *)ancientId;
- (void )downloadAllBook:(NSNumber *)bookId;
- (void )downloadAllSurvival:(NSNumber *)survivalId;
- (void )downloadAllFight:(NSNumber *)fightId;
- (void )downloadAllDress:(NSNumber *)dressId;

- (void )userRegister:(NSDictionary *)userInformation;
- (void )userLogin:(NSDictionary *)userInformation;
- (void )addQuestion:(NSDictionary *)questionInformation;
- (void )downloadAllQuestion:(NSNumber *)date direction:(NSNumber *)direction;
- (void )commentQuestion:(NSDictionary *)information;
- (void )downloadQuestionComment:(NSNumber *)questionId date:(NSNumber *)date;
- (void )downloadQuestionReply:(NSNumber *)questionId;



@end
