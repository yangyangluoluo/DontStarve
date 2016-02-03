//
//  MagicModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/25.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Magic+CoreDataProperties.h"
#import "MixNeed+CoreDataProperties.h"
#import "MagicModel.h"

@implementation MagicModel

- (instancetype )init{
    self = [super init];
    if (self) {
        self.entityname = @"Magic";
        self.entyArr = @"magic_id";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        self.data = nil;
    }
    return self;
}

- (void )downloadData{
    Magic *last = self.manager.fetchResultController.fetchedObjects.lastObject;
    NSNumber *index = @0;
    if (last!=nil) {
        index = last.magic_id;
    }
    NSString *urlStr = [self.webData setUrlString:ALLMAGIC address1:index];
    [self downloadAddress:urlStr];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"magic_id"] intValue]];
        NSString *pridect = @"magic_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]){
            Magic *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Magic" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.magic_id = [NSNumber numberWithInt:[[dic objectForKey:@"magic_id"] intValue]];
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
                need.relationship = addOneCoreData;
            }
        }
    }
    [self.manager saveContext];
}

@end
