//
//  CharacterDetailModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/7.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "CellProtocol.h"
#import "BaseModel.h"

@interface CharacterDetailModel : BaseModel<CellProtocol>

@property (strong,nonatomic) NSFetchedResultsController *fetchResultController;

- (instancetype)initWithId:(NSNumber *)characterId;
- (NSString *)getAtk:(NSUInteger)index;
- (NSString *)getMotto:(NSUInteger)index;
- (NSString *)getUnlock:(NSUInteger)index;
- (NSString *)getAbility:(NSUInteger)index;
- (NSString *)getIntroduce:(NSUInteger)index;
- (NSString *)getUrlSt:(NSUInteger)index;
@end
