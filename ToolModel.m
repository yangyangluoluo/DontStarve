//
//  ToolModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/23.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "ToolModel.h"
#import "Tools+CoreDataProperties.h"
#import "MixNeed+CoreDataProperties.h"
@implementation ToolModel

- (instancetype )init{
    self = [super init];
    if (self) {
        NSString *entityname = @"Tools";
        NSString *idName = @"tools_id";
        [self setFectch:entityname sort:idName];
        [self bindWithReactive];
        self.allData = nil;
    }
    return self;
}

- (void )bindWithReactive{
    @weakify(self);
    [RACObserve(self.webData, allTool) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allData = x;
        }
    }];
}

- (void )downloadData{
    NSString *entityname = @"Tools";
    NSString *idName = @"tools_id";
    NSUInteger maxId = [self getMaxId:entityname name:idName];
    [self.webData downloadAllTool:@(maxId)];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.allData) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"tools_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Tools"];
        request.predicate = [NSPredicate predicateWithFormat:@"tools_id=%@",theId];
        NSArray *coreData = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (coreData.count==0) {
            Tools *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Tools" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.tools_id = [NSNumber numberWithInt:[[dic objectForKey:@"tools_id"] intValue]];
            addOneCoreData.name = [dic objectForKey:@"name"];
            addOneCoreData.atk = @([[dic objectForKey:@"atk"] floatValue]);
            addOneCoreData.technology = [dic objectForKey:@"technology"];
            addOneCoreData.during = @([[dic objectForKey:@"during"] floatValue]);
            addOneCoreData.mixCode = [dic objectForKey:@"mixCode"];
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
