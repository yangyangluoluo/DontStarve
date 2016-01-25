//
//  RefineModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/25.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "RefineModel.h"
#import "Refine+CoreDataProperties.h"
#import "MixNeed+CoreDataProperties.h"
@implementation RefineModel

- (instancetype )init{
    self = [super init];
    if (self) {
        NSString *entityname = @"Refine";
        NSString *idName = @"refine_id";
        [self setFectch:entityname sort:idName];
        [self bindWithReactive];
        self.allData = nil;
    }
    return self;
}

- (void )bindWithReactive{
    @weakify(self);
    [RACObserve(self.webData, allRefine) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allData = x;
        }
    }];
}

- (void )downloadData{
    NSString *entityname = @"Refine";
    NSString *idName = @"refine_id";
    NSUInteger maxId = [self getMaxId:entityname name:idName];
    [self.webData downloadAllRefine:@(maxId)];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.allData) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"refine_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Refine"];
        request.predicate = [NSPredicate predicateWithFormat:@"refine_id=%@",theId];
        NSArray *coreData = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (coreData.count==0) {
            Refine *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Refine" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.refine_id = [NSNumber numberWithInt:[[dic objectForKey:@"refine_id"] intValue]];
            addOneCoreData.name = [dic objectForKey:@"name"];
            addOneCoreData.technology = [dic objectForKey:@"technology"];
            addOneCoreData.stackNum = [dic objectForKey:@"stackNum"];
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
                need.relationship3 = addOneCoreData;
            }
        }
    }
    [self.manager saveContext];
}

@end
