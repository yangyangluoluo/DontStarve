//
//  BossDetailModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/14.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BossDetailModel.h"
#import "Boss+CoreDataProperties.h"
#import "BossTrait+CoreDataProperties.h"
@interface BossDetailModel()

@property (strong,nonatomic) NSNumber *bossId;

@end


@implementation BossDetailModel

- (instancetype)initWitdBossId:(NSNumber *)bossId;{
    self = [super init];
    if (self) {
        self.bossId = bossId;
        [self getFetchResultController];
        [self bindWithReactive];
        self.allData = nil;
    }
    return self;
}

- (void )bindWithReactive{
    @weakify(self);
    [RACObserve(self.webData, bossTrait) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allData = x;
        }
    }];
}

- (NSUInteger )getCount{
    return self.fetchResultController.fetchedObjects.count;
}

- (NSUInteger )getType0Count{
    if ([[self.fetchResultController sections] count]!=0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchResultController sections] objectAtIndex:0];
        return  [sectionInfo numberOfObjects];
    }else{
        return 0;
    }
    
}
- (NSUInteger )getType1Count{
    if ([[self.fetchResultController sections] count]!=0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchResultController sections] objectAtIndex:1];
        return  [sectionInfo numberOfObjects];
    }else{
        return 0;
    }
}




- (NSFetchedResultsController *)getFetchResultController{
    if (self.fetchResultController!=nil) {
        return self.fetchResultController;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"BossTrait"];
    request.predicate = [NSPredicate predicateWithFormat:@"boss_id=%@",self.bossId];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"boss_id" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    request.sortDescriptors = sortDescriptors;
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.manager.managedObjectContext sectionNameKeyPath:@"type" cacheName:nil];
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
    if (self.fetchResultController.fetchedObjects.count == 0) {
        [self.webData downloadBossTrait:self.bossId];
    }
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.allData) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"bossTrait_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"BossTrait"];
        request.predicate = [NSPredicate predicateWithFormat:@"bossTrait_id=%@",theId];
        NSArray *bosses = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (bosses.count==0) {
            BossTrait *bossTrait = [NSEntityDescription insertNewObjectForEntityForName:@"BossTrait" inManagedObjectContext:self.manager.managedObjectContext];
            bossTrait.bossTrait_id = @([[dic objectForKey:@"bossTrait_id"] intValue]);
            bossTrait.boss_id = @([[dic objectForKey:@"boss_id"] intValue]);
            bossTrait.describe = [dic objectForKey:@"describe"];
            bossTrait.type = @([[dic objectForKey:@"type"] intValue]);
        }
    }
    [self.manager saveContext];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    switch(type) {
        case NSFetchedResultsChangeInsert:{
            self.reload = @1;
            break;
        }
        case NSFetchedResultsChangeDelete:{
            
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            
            break;
        }
        case NSFetchedResultsChangeMove:{
            break;
        }
        default:{
            break;
        }
    }
}


@end
