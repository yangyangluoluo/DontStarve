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
        self.entityname = @"Refine";
        self.entyArr = @"refine_id";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        self.data = nil;
    }
    return self;
}

- (void )downloadData{
    Refine *last = self.manager.fetchResultController.fetchedObjects.lastObject;
    NSNumber *index = @0;
    if (last!=nil) {
        index = last.refine_id;
    }
    NSString *urlStr = [self.webData setUrlString:ALLREFINE address1:index];
    [self downloadAddress:urlStr];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"refine_id"] intValue]];
        NSString *pridect = @"refine_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]){
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
