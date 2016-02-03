//
//  FoodRawModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/15.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "FoodRawModel.h"
#import "FoodRaw+CoreDataProperties.h"
@implementation FoodRawModel

- (instancetype )init{
    self = [super init];
    if (self) {
        self.entityname = @"FoodRaw";
        self.entyArr = @"foodRaw_id";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        self.data = nil;
    }
    return self;
}

- (void )downloadData{
    FoodRaw *last = self.manager.fetchResultController.fetchedObjects.firstObject;
    NSNumber *index = @0;
    if (last!=nil) {
        index = last.foodRaw_id;
    }
    NSString *urlStr = [self.webData setUrlString:ALLFOODRAW address1:index];
    [self downloadAddress:urlStr];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"foodRaw_id"] intValue]];
        NSString *pridect = @"foodRaw_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]) {
            FoodRaw *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"FoodRaw" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.foodRaw_id = [NSNumber numberWithInt:[[dic objectForKey:@"foodRaw_id"] intValue]];
            addOneCoreData.chName = [dic objectForKey:@"chName"];
            addOneCoreData.enName = [dic objectForKey:@"enName"];
            addOneCoreData.life = @([[dic objectForKey:@"life"] floatValue]);
            addOneCoreData.hunger = @([[dic objectForKey:@"hunger"] floatValue]);
            addOneCoreData.sanity = @([[dic objectForKey:@"sanity"] floatValue]);
            addOneCoreData.badCycle = @([[dic objectForKey:@"badCycle"] floatValue]);
            addOneCoreData.edibleMethod =[dic objectForKey:@"edibleMethod"];
            addOneCoreData.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            addOneCoreData.urlStr = [addOneCoreData.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
    }
    [self.manager saveContext];
}


@end
