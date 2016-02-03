//
//  PlantModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/10.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "PlantModel.h"

@implementation PlantModel
- (instancetype )init{
    self = [super init];
    if (self) {
        self.entityname = @"Plant";
        self.entyArr = @"plant_id";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        self.data = nil;
    }
    return self;
}

- (void )downloadData{
    Plant *last = self.manager.fetchResultController.fetchedObjects.lastObject;
    NSNumber *index = @0;
    if (last!=nil) {
        index = last.plant_id;
    }
    NSString *urlStr = [self.webData setUrlString:ALLPLANT address1:index];
    [self downloadAddress:urlStr];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"plant_id"] intValue]];
        NSString *pridect = @"plant_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]) {
            Plant *plant = [NSEntityDescription insertNewObjectForEntityForName:@"Plant" inManagedObjectContext:self.manager.managedObjectContext];
            plant.plant_id = [NSNumber numberWithInt:[[dic objectForKey:@"plant_id"] intValue]];
            plant.name = [dic objectForKey:@"name"];
            plant.describe = [dic objectForKey:@"describe"];
            plant.produce =[dic objectForKey:@"produce"];
            plant.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            plant.urlStr = [plant.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
    }
    [self.manager saveContext];
}
@end
