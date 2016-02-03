//
//  BossModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/13.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BossModel.h"

@implementation BossModel

- (instancetype )init{
    self = [super init];
    if (self) {
        self.entityname = @"Boss";
        self.entyArr = @"boss_Id";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        self.data = nil;
    }
    return self;
}

- (void )downloadData{
    Boss *last = self.manager.fetchResultController.fetchedObjects.firstObject;
    NSNumber *index = @0;
    if (last!=nil) {
        index = last.boss_Id;
    }
    NSString *urlStr = [self.webData setUrlString:ALLBOSS address1:index];
    [self downloadAddress:urlStr];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"boss_Id"] intValue]];
        NSString *pridect = @"boss_Id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]) {
            Boss *boss = [NSEntityDescription insertNewObjectForEntityForName:@"Boss" inManagedObjectContext:self.manager.managedObjectContext];
            boss.boss_Id = @([[dic objectForKey:@"boss_Id"] intValue]);
            boss.chName = [dic objectForKey:@"chName"];
            boss.enName = [dic objectForKey:@"enName"];
            boss.bossType =[dic objectForKey:@"bossType"];
            boss.life =[dic objectForKey:@"life"];
            boss.atk =[dic objectForKey:@"atk"];
            boss.atkPeriod =[dic objectForKey:@"atkPeriod"];
            boss.atkRange =[dic objectForKey:@"atkRange"];
            boss.moveSpeed =[dic objectForKey:@"moveSpeed"];
            boss.sanityEffect =[dic objectForKey:@"sanityEffect"];
            boss.specialAbility =[dic objectForKey:@"specialAbility"];
            boss.loot =[dic objectForKey:@"loot"];
            boss.bornRegion =[dic objectForKey:@"bornRegion"];
            boss.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            boss.urlStr = [boss.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
    }
    [self.manager saveContext];
}
@end
