//
//  AnimalModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/8.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "CellProtocol.h"
#import "BaseModel.h"

@interface AnimalModel : BaseModel<CellProtocol>

@property (strong,nonatomic) NSArray *allAnimal;
@property (strong,nonatomic) NSArray *friendly;
@property (strong,nonatomic) NSArray *neutrally;
@property (strong,nonatomic) NSArray *hostility;
@property (strong,nonatomic) NSNumber *reload;
@property (strong,nonatomic) NSFetchedResultsController *fetchResultController;

- (NSUInteger )getFrinedlyCount;
- (NSUInteger )getNeutrallyCount;
- (NSUInteger )getHostilityCount;
- (NSString *)getChName:(NSUInteger)section row:(NSUInteger)row;
- (NSString *)getEnName:(NSUInteger)section row:(NSUInteger)row;
- (NSString *)getImageUrlStr:(NSUInteger)section row:(NSUInteger)row;



@end
