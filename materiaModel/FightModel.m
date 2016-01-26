//
//  FightModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/26.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "FightModel.h"
#import "Fight+CoreDataProperties.h"
#import "MixNeed+CoreDataProperties.h"
@implementation FightModel

- (instancetype )init{
    self = [super init];
    if (self) {
        NSString *entityname = @"Fight";
        NSString *idName = @"fight_id";
        [self setFectch:entityname sort:idName];
        [self bindWithReactive];
        self.allData = nil;
    }
    return self;
}

- (void )bindWithReactive{
    @weakify(self);
    [RACObserve(self.webData, homeData1) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allData = x;
        }
    }];
}

- (void )downloadData{
    NSString *entityname = @"Fight";
    NSString *idName = @"fight_id";
    NSUInteger maxId = [self getMaxId:entityname name:idName];
    [self.webData downloadAllFight:@(maxId)];
}

- (void )saveDataToCoreData{
    
    for (NSDictionary *dic in self.allData) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"fight_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Fight"];
        request.predicate = [NSPredicate predicateWithFormat:@"fight_id=%@",theId];
        NSArray *coreData = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (coreData.count==0) {
            Fight *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Fight" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.fight_id = @([[dic objectForKey:@"fight_id"] intValue]);
            addOneCoreData.name = [dic objectForKey:@"name"];
            addOneCoreData.technology = [dic objectForKey:@"technology"];
            addOneCoreData.atk = [dic objectForKey:@"atk"];
            addOneCoreData.during = [dic objectForKey:@"during"];
            addOneCoreData.special = [dic objectForKey:@"special"];
            addOneCoreData.code = [dic objectForKey:@"code"];
            addOneCoreData.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            addOneCoreData.urlStr = [addOneCoreData.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];

            for (NSDictionary *dic2 in (NSArray *)[dic objectForKey:@"mixNeed"]) {
                MixNeed *need = [NSEntityDescription insertNewObjectForEntityForName:@"MixNeed" inManagedObjectContext:self.manager.managedObjectContext];
                need.mixNeed_id = @([[dic2 objectForKey:@"mixNeed_id"] intValue]);
                need.num = @([[dic2 objectForKey:@"num"] floatValue]);
                need.name = [dic2 objectForKey:@"name"];
                need.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic2 objectForKey:@"urlStr"]];
                need.urlStr = [need.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
                need.relationship10 = addOneCoreData;
            }
        }
    }
    [self.manager saveContext];
    
}



@end
