//
//  CharactersModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/6.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "CellProtocol.h"
#import "BaseModel.h"
#import <CoreData/CoreData.h>
#import "Characters+CoreDataProperties.h"
@interface CharactersModel : BaseModel<CellProtocol>

@property (strong,nonatomic) NSArray *allCharacters;

- (instancetype)init;
- (void )downloadData;
- (void )saveDataToCoreData;
- (NSUInteger)getCount;
- (NSString *)getImageUrlStr:(NSUInteger)index;
- (NSString *)getName:(NSUInteger)index;
- (NSString *)getNickname:(NSUInteger)index;
- (NSString *)getHungry:(NSUInteger)index;
- (NSString *)getLife:(NSUInteger)index;
- (NSString *)getSanity:(NSUInteger)index;
- (NSNumber *)getId:(NSUInteger)index;


@end
