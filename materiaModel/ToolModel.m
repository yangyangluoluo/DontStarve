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
        self.entityname = @"Tools";
        self.entyArr = @"tools_id";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        self.data = nil;
    }
    return self;
}

- (void )downloadData{
    Tools *last = self.manager.fetchResultController.fetchedObjects.lastObject;
    NSNumber *index = @0;
    if (last!=nil) {
        index = last.tools_id;
    }
    NSString *urlStr = [self.webData setUrlString:ALLTOOL address1:index];
    [self downloadAddress:urlStr];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"tools_id"] intValue]];
        NSString *pridect = @"tools_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]){
            Tools *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Tools" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.tools_id = [NSNumber numberWithInt:[[dic objectForKey:@"tools_id"] intValue]];
            addOneCoreData.name = [dic objectForKey:@"name"];
            addOneCoreData.atk = @([[dic objectForKey:@"atk"] floatValue]);
            addOneCoreData.technology = [dic objectForKey:@"technology"];
            addOneCoreData.during = @([[dic objectForKey:@"during"] floatValue]);
            addOneCoreData.mixCode = [dic objectForKey:@"mixCode"];
            addOneCoreData.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            addOneCoreData.urlStr = [addOneCoreData.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            
            for (NSDictionary *dic2 in (NSArray *)[dic objectForKey:@"mixNeed"]) {
                MixNeed *need = [NSEntityDescription insertNewObjectForEntityForName:@"MixNeed" inManagedObjectContext:self.manager.managedObjectContext];
                need.mixNeed_id = @([[dic2 objectForKey:@"mixNeed_id"] intValue]);
                need.num = @([[dic2 objectForKey:@"num"] floatValue]);
                need.name = [dic2 objectForKey:@"name"];
                need.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic2 objectForKey:@"urlStr"]];
                need.urlStr = [need.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
                need.relationship6 = addOneCoreData;
            }
        }
    }
    [self.manager saveContext];
    
}

@end
