//
//  BossModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/13.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BossModel.h"
#import "Boss+CoreDataProperties.h"
@implementation BossModel

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
    [RACObserve(self.webData, allBoss) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allData = x;
        }
    }];
}

- (NSUInteger )getCount{
    return self.fetchResultController.fetchedObjects.count;
}

- (Boss *)getBoss:(NSUInteger)row{
    return self.fetchResultController.fetchedObjects[row];
}

- (NSFetchedResultsController *)getFetchResultController{
    if (self.fetchResultController!=nil) {
        return self.fetchResultController;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Boss"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"boss_Id" ascending:YES];
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
    NSArray *bosses = self.fetchResultController.fetchedObjects;
    if (bosses.count == 0) {
        [self.webData  downloadBoss:@0];
    }else{
        Boss *boss = [bosses lastObject];
        [self.webData downloadBoss:boss.boss_Id];
    }
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.allData) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"boss_Id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Boss"];
        request.predicate = [NSPredicate predicateWithFormat:@"boss_Id=%@",theId];
        NSArray *bosses = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (bosses.count==0) {
            Boss *boss = [NSEntityDescription insertNewObjectForEntityForName:@"Boss" inManagedObjectContext:self.manager.managedObjectContext];
            boss.boss_Id = [NSNumber numberWithInt:[[dic objectForKey:@"boss_Id"] intValue]];
            boss.chName = [dic objectForKey:@"chName"];
            boss.enName = [dic objectForKey:@"enName"];
            boss.bossType =[dic objectForKey:@"bossType"];
            boss.life =[dic objectForKey:@"life"];
            boss.atk =[dic objectForKey:@"atk"];
            boss.atkPeriod =[dic objectForKey:@"atkPeriod"];
            boss.atkRange =[dic objectForKey:@"atkRange"];
            boss.moveSpeed =[dic objectForKey:@"moveSpeed"];
            boss.sanityEffect =[dic objectForKey:@"sanityEffect"];
            boss.specialAbility =[dic objectForKey:@"specialAbility"];
            boss.loot =[dic objectForKey:@"loot"];
            boss.bornRegion =[dic objectForKey:@"bornRegion"];
            boss.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
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
