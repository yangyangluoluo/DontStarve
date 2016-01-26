//
//  FoodRawModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/15.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "FoodRawModel.h"
#import "FoodRaw+CoreDataProperties.h"
@implementation FoodRawModel

- (instancetype )init{
    self = [super init];
    if (self) {
        [self getFetchResultController];
        [self bindWithReactive];
        self.allData = nil;
    }
    return self;
}

- (void )bindWithReactive{
    @weakify(self);
    [RACObserve(self.webData, homeData1) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allData = x;
        }
    }];
}

- (NSUInteger )getCount{
    return self.fetchResultController.fetchedObjects.count;
}

- (FoodRaw *)getFoodRaw:(NSUInteger)row{
    return self.fetchResultController.fetchedObjects[row];
}

- (NSFetchedResultsController *)getFetchResultController{
    if (self.fetchResultController!=nil) {
        return self.fetchResultController;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"FoodRaw"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"foodRaw_id" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    request.sortDescriptors = sortDescriptors;
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.manager.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    self.fetchResultController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchResultController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return self.fetchResultController;
}

- (void )downloadData{
    NSArray *allCoreData = self.fetchResultController.fetchedObjects;
    if (allCoreData.count == 0) {
        [self.webData  downloadAllFoodRaw:@0];
    }else{
        FoodRaw *data = [allCoreData lastObject];
        [self.webData downloadAllFoodRaw:data.foodRaw_id];
    }
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.allData) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"foodRaw_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"FoodRaw"];
        request.predicate = [NSPredicate predicateWithFormat:@"foodRaw_id=%@",theId];
        NSArray *coreData = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (coreData.count==0) {
            FoodRaw *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"FoodRaw" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.foodRaw_id = [NSNumber numberWithInt:[[dic objectForKey:@"foodRaw_id"] intValue]];
            addOneCoreData.chName = [dic objectForKey:@"chName"];
            addOneCoreData.enName = [dic objectForKey:@"enName"];
            addOneCoreData.life = @([[dic objectForKey:@"life"] floatValue]);
            addOneCoreData.hunger = @([[dic objectForKey:@"hunger"] floatValue]);
            addOneCoreData.sanity = @([[dic objectForKey:@"sanity"] floatValue]);
            addOneCoreData.badCycle = @([[dic objectForKey:@"badCycle"] floatValue]);
            addOneCoreData.edibleMethod =[dic objectForKey:@"edibleMethod"];
            addOneCoreData.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            addOneCoreData.urlStr = [addOneCoreData.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
    }
    [self.manager saveContext];
}


@end
