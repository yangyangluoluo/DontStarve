//
//  HomeModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/6.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "HomeModel.h"
#import "HomeDescribe.h"
@interface HomeModel ()

@property (strong,nonatomic) NSMutableArray *titles;

@end

@implementation HomeModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.titles = [[NSMutableArray alloc]init];
        HomeDescribe *d11 = [[HomeDescribe alloc]initWitchName:@"人物" enName:@"character" icon:@"Icon_Characters.jpeg"];
        HomeDescribe *d12 = [[HomeDescribe alloc]initWitchName:@"动物" enName:@"Animal" icon:@"Icon_Animal.png"];
        HomeDescribe *d13 = [[HomeDescribe alloc]initWitchName:@"植物" enName:@"Plant" icon:@"Icon_Plant.png"];
        HomeDescribe *d14 = [[HomeDescribe alloc]initWitchName:@"建筑" enName:@"Build" icon:@"Icon_Build.png"];
        HomeDescribe *d15 = [[HomeDescribe alloc]initWitchName:@"BOSS" enName:@"Boss" icon:@"Icon_Boss.png"];
        HomeDescribe *d16 = [[HomeDescribe alloc]initWitchName:@"食谱" enName:@"Recipe" icon:@"Icon_Recipe.png"];
        HomeDescribe *d17 = [[HomeDescribe alloc]initWitchName:@"食材原料" enName:@"FoodRaw" icon:@"Icon_FoodRaw.png"];
        NSArray *title1 = @[d11,d12,d13,d14,d15,d16,d17];
        [self.titles addObject:title1];
        
        HomeDescribe *d31 = [[HomeDescribe alloc]initWitchName:@"工具" enName:@"Tools" icon:@"Icon_Tools.png"];
        HomeDescribe *d32 = [[HomeDescribe alloc]initWitchName:@"光源" enName:@"Fire" icon:@"Icon_Fire.png"];
        HomeDescribe *d33 = [[HomeDescribe alloc]initWitchName:@"生存" enName:@"Survival" icon:@"Icon_Survival.png"];
        HomeDescribe *d34 = [[HomeDescribe alloc]initWitchName:@"生产" enName:@"produce" icon:@"Icon_Food.png"];
        HomeDescribe *d35 = [[HomeDescribe alloc]initWitchName:@"科学" enName:@"Science" icon:@"Icon_Science.png"];
        HomeDescribe *d36 = [[HomeDescribe alloc]initWitchName:@"战斗" enName:@"Fight" icon:@"Icon_Fight.png"];
        HomeDescribe *d37 = [[HomeDescribe alloc]initWitchName:@"建筑" enName:@"Build" icon:@"Icon_Build.png"];
        HomeDescribe *d38 = [[HomeDescribe alloc]initWitchName:@"精制" enName:@"Refine" icon:@"Icon_Refine.png"];
        HomeDescribe *d39 = [[HomeDescribe alloc]initWitchName:@"魔法" enName:@"Magic" icon:@"Icon_Magic.png"];
        HomeDescribe *d310 = [[HomeDescribe alloc]initWitchName:@"服装" enName:@"Dress" icon:@"Icon_Dress.png"];
        HomeDescribe *d311 = [[HomeDescribe alloc]initWitchName:@"书本" enName:@"Book" icon:@"Icon_Book.png"];
        HomeDescribe *d312 = [[HomeDescribe alloc]initWitchName:@"远古" enName:@"Acient" icon:@"Icon_Acient.png"];
        NSArray *title2 =@[d31,d32,d33,d34,d35,d36,d37,d38,d39,d310,d311,d312];
        [self.titles addObject:title2];
    }
    return self;
}

- (HomeDescribe *)getDescribe:(NSUInteger)section row:(NSUInteger)row;{
    return self.titles[section][row];
}


- (NSUInteger )getCount{
    return self.titles.count;
}


- (NSUInteger)getSectionCount:(NSUInteger)section{
    return [self.titles[section] count];
}
@end
