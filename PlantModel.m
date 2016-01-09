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
        [self getFetchResultController];
        [self bindWithReactive];
        self.allData = nil;
    }
    return self;
}

- (void )bindWithReactive{
    @weakify(self);
    [RACObserve(self.webData, allPlant) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allData = x;
        }
    }];
}

- (NSUInteger )getCount{
    return self.fetchResultController.fetchedObjects.count;
}

- (Plant *)getPlant:(NSUInteger)row{
    return self.fetchResultController.fetchedObjects[row];
}

- (NSFetchedResultsController *)getFetchResultController{
    if (self.fetchResultController!=nil) {
        return self.fetchResultController;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Plant"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"plant_id" ascending:YES];
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
    NSArray *plants = self.fetchResultController.fetchedObjects;
    if (plants.count == 0) {
        [self.webData  downloadAllPlant:@0];
    }else{
        Plant *plant = [plants lastObject];
        [self.webData downloadAllPlant:plant.plant_id];
    }
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.allData) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"plant_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Plant"];
        request.predicate = [NSPredicate predicateWithFormat:@"plant_id=%@",theId];
        NSArray *plants = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (plants.count==0) {
            Plant *plant = [NSEntityDescription insertNewObjectForEntityForName:@"Plant" inManagedObjectContext:self.manager.managedObjectContext];
            plant.plant_id = [NSNumber numberWithInt:[[dic objectForKey:@"plant_id"] intValue]];
            plant.name = [dic objectForKey:@"name"];
            plant.describe = [dic objectForKey:@"describe"];
            plant.produce =[dic objectForKey:@"produce"];
            plant.urlStr = [dic objectForKey:@"urlStr"];
        }
    }
    [self.manager saveContext];
}



@end
