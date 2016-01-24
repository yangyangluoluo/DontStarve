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
        NSString *entityname = @"Fire";
        NSString *idName = @"fire_id";
        [self setFectch:entityname sort:idName];
        [self bindWithReactive];
        self.allData = nil;
    }
    return self;
}

- (void )bindWithReactive{
    @weakify(self);
    [RACObserve(self.webData, allFire) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allData = x;
        }
    }];
}

- (void )downloadData{
    NSString *entityname = @"Fire";
    NSString *idName = @"fire_id";
    NSUInteger maxId = [self getMaxId:entityname name:idName];
    [self.webData downloadAllFire:@(maxId)];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.allData) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"fire_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Fire"];
        request.predicate = [NSPredicate predicateWithFormat:@"fire_id=%@",theId];
        NSArray *coreData = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (coreData.count==0) {
            Fire *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Fire" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.fire_id = [NSNumber numberWithInt:[[dic objectForKey:@"fire_id"] intValue]];
            addOneCoreData.name = [dic objectForKey:@"name"];
            addOneCoreData.technology = [dic objectForKey:@"technology"];
            addOneCoreData.time = [dic objectForKey:@"time"];
            addOneCoreData.maxTime = [dic objectForKey:@"maxTime"];
            addOneCoreData.code = [dic objectForKey:@"code"];
            addOneCoreData.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            addOneCoreData.urlStr = [addOneCoreData.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            
            NSMutableSet *needSet = [[NSMutableSet alloc]init];
            NSUInteger index = 0;
            for (NSDictionary *dic2 in (NSArray *)[dic objectForKey:@"mixNeed"]) {
                MixNeed *need = [NSEntityDescription insertNewObjectForEntityForName:@"MixNeed" inManagedObjectContext:self.manager.managedObjectContext];
                need.mixNeed_id = @([[dic2 objectForKey:@"mixNeed_id"] intValue]);
                need.num = @([[dic2 objectForKey:@"num"] floatValue]);
                need.name = [dic2 objectForKey:@"name"];
                need.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic2 objectForKey:@"urlStr"]];
                need.urlStr = [need.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
                [needSet addObject:need];
                index++;
            }
            [addOneCoreData addRelationship:needSet];
        }
    }
    [self.manager saveContext];
    
}


@end
