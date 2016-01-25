//
//  BuildModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/25.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BuildModel.h"
#import "Build+CoreDataProperties.h"
#import "MixNeed+CoreDataProperties.m"
@implementation BuildModel

- (instancetype )init{
    self = [super init];
    if (self) {
        NSString *entityname = @"Build";
        NSString *idName = @"build_id";
        [self setFectch:entityname sort:idName];
        [self bindWithReactive];
        self.allData = nil;
    }
    return self;
}

- (void )bindWithReactive{
    @weakify(self);
    [RACObserve(self.webData, allBuild) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allData = x;
        }
    }];
}

- (void )downloadData{
    NSString *entityname = @"Build";
    NSString *idName = @"build_id";
    NSUInteger maxId = [self getMaxId:entityname name:idName];
    [self.webData downloadAllBuild:@(maxId)];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.allData) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"build_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Build"];
        request.predicate = [NSPredicate predicateWithFormat:@"build_id=%@",theId];
        NSArray *coreData = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (coreData.count==0) {
            Build *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Build" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.build_id = [NSNumber numberWithInt:[[dic objectForKey:@"build_id"] intValue]];
            addOneCoreData.name = [dic objectForKey:@"name"];
            addOneCoreData.technology = [dic objectForKey:@"technology"];
            addOneCoreData.function = [dic objectForKey:@"function"];
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
                need.relationship5 = addOneCoreData;
            }
        }
    }
    [self.manager saveContext];
}

@end
