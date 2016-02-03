//
//  FireModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/24.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "FireModel.h"
#import "Fire+CoreDataProperties.h"
#import "MixNeed+CoreDataProperties.h"
@implementation FireModel

- (instancetype )init{
    self = [super init];
    if (self) {
        self.entityname = @"Fire";
        self.entyArr = @"fire_id";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        self.data = nil;
    }
    return self;
}

- (void )downloadData{
    
    Fire *last = self.manager.fetchResultController.fetchedObjects.lastObject;
    NSNumber *index = @0;
    if (last!=nil) {
        index = last.fire_id;
    }
    NSString *urlStr = [self.webData setUrlString:ALLFIRE address1:index];
    [self downloadAddress:urlStr];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"fire_id"] intValue]];
        NSString *pridect = @"fire_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]){
            Fire *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Fire" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.fire_id = [NSNumber numberWithInt:[[dic objectForKey:@"fire_id"] intValue]];
            addOneCoreData.name = [dic objectForKey:@"name"];
            addOneCoreData.technology = [dic objectForKey:@"technology"];
            addOneCoreData.time = [dic objectForKey:@"time"];
            addOneCoreData.maxTime = [dic objectForKey:@"maxTime"];
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
                need.relationship1 = addOneCoreData;
            }
        }
    }
    [self.manager saveContext];
}


@end
