//
//  AnimalModel.h
//  DontStarve
//
//  Created by 李建国 on 16/1/8.
//  Copyright © 2016年 李建国. All rights reserved.
//
@class Animal;
#import "CellProtocol.h"
#import "BaseModel.h"

@interface AnimalModel : BaseModel<CellProtocol>

@property (strong,nonatomic) NSArray *allAnimal;

- (NSUInteger )getFrinedlyCount;
- (NSUInteger )getNeutrallyCount;
- (NSUInteger )getHostilityCount;
- (NSString *)getChName:(NSUInteger)section row:(NSUInteger)row;
- (NSString *)getEnName:(NSUInteger)section row:(NSUInteger)row;
- (NSString *)getImageUrlStr:(NSUInteger)section row:(NSUInteger)row;
- (Animal *)getAnimal:(NSUInteger)section row:(NSUInteger)row;



@end