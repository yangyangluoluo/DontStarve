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

- (Construction *)getConstruction:(NSUInteger)row{
    return self.fetchResultController.fetchedObjects[row];
}

- (NSFetchedResultsController *)getFetchResultController{
    if (self.fetchResultController!=nil) {
        return self.fetchResultController;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Construction"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"construction_id" ascending:YES];
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
    NSArray *constructions = self.fetchResultController.fetchedObjects;
    if (constructions.count == 0) {
        [self.webData  downloadConstruction:@0];
    }else{
        Construction *construction = [constructions lastObject];
        [self.webData downloadConstruction:construction.construction_id];
    }
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.allData) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"construction_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Construction"];
        request.predicate = [NSPredicate predicateWithFormat:@"construction_id=%@",theId];
        NSArray *constructions = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (constructions.count==0) {
            Construction *construction = [NSEntityDescription insertNewObjectForEntityForName:@"Construction" inManagedObjectContext:self.manager.managedObjectContext];
            construction.construction_id = [NSNumber numberWithInt:[[dic objectForKey:@"construction_id"] intValue]];
            construction.name = [dic objectForKey:@"name"];
            construction.describe = [dic objectForKey:@"describe"];
            construction.produce =[dic objectForKey:@"produce"];
            construction.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
        }
    }
    [self.manager saveContext];
}


@end
