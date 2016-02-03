//
//  ConstructionModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/11.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "ConstructionModel.h"

@implementation ConstructionModel

- (instancetype )init{
    self = [super init];
    if (self) {
        self.entityname = @"Construction";
        self.entyArr = @"construction_id";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        self.data = nil;
    }
    return self;
}

- (void )downloadData{    
    Construction *last = self.manager.fetchResultController.fetchedObjects.lastObject;
    NSNumber *index = @0;
    if (last!=nil) {
        index = last.construction_id;
    }
    NSString *urlStr = [self.webData setUrlString:ALLCONSTRUCT address1:index];
    [self downloadAddress:urlStr];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"construction_id"] intValue]];
        NSString *pridect = @"construction_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]) {
            Construction *construction = [NSEntityDescription insertNewObjectForEntityForName:@"Construction" inManagedObjectContext:self.manager.managedObjectContext];
            construction.construction_id = [NSNumber numberWithInt:[[dic objectForKey:@"construction_id"] intValue]];
            construction.name = [dic objectForKey:@"name"];
            construction.describe = [dic objectForKey:@"describe"];
            construction.produce =[dic objectForKey:@"produce"];
            construction.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            construction.urlStr = [construction.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
    }
    [self.manager saveContext];
}


@end
