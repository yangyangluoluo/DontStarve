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
        self.entityname = @"Fight";
        self.entyArr = @"fight_id";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        self.data = nil;
    }
    return self;
}

- (void )downloadData{
    
    Fight *last = self.manager.fetchResultController.fetchedObjects.lastObject;
    NSNumber *index = @0;
    if (last!=nil) {
        index = last.fight_id;
    }
    NSString *urlStr = [self.webData setUrlString:ALLFIGHT address1:index];
    [self downloadAddress:urlStr];
}

- (void )saveDataToCoreData{
    
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"fight_id"] intValue]];
        NSString *pridect = @"fight_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]){
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
