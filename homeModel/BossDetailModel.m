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
        self.entityname = @"BossTrait";
        self.entyArr = @"bossTrait_id";
        [self initFetchResultController];
        self.data = nil;
    }
    return self;
}

- (void )initFetchResultController{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"BossTrait"];
    request.predicate =[NSPredicate predicateWithFormat:@"boss_id=%@",self.bossId];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"bossTrait_id" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    request.sortDescriptors = sortDescriptors;
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.manager.managedObjectContext sectionNameKeyPath:@"type" cacheName:nil];
    self.manager.fetchResultController = aFetchedResultsController;
    [self.manager setDeletegate];
    
    NSError *error = nil;
    if (![self.manager.fetchResultController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (NSUInteger )getType0Count{
    if ([[self.manager.fetchResultController sections] count]!=0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.manager.fetchResultController sections] objectAtIndex:0];
        return  [sectionInfo numberOfObjects];
    }else{
        return 0;
    }
    
}
- (NSUInteger )getType1Count{
    if ([[self.manager.fetchResultController sections] count]!=0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.manager.fetchResultController sections] objectAtIndex:1];
        return  [sectionInfo numberOfObjects];
    }else{
        return 0;
    }
}

- (NSUInteger )getSectionCount{
    return self.manager.fetchResultController.sections.count;
}

- (NSString *)getDescribe:(NSUInteger)section andRow:(NSUInteger)row{
    --section;
    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:section];
    BossTrait *bossTrait = [self.manager.fetchResultController objectAtIndexPath:index];
    return bossTrait.describe;
}

- (void )downloadData{
    if (self.manager.fetchResultController.fetchedObjects.count == ZERO) {
        NSString *urlStr = [self.webData setUrlString:BOSSTRAIT address1:self.bossId];
        [self downloadAddress:urlStr];
    }
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"bossTrait_id"] intValue]];
        NSString *pridect = @"bossTrait_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]) {
            BossTrait *bossTrait = [NSEntityDescription insertNewObjectForEntityForName:@"BossTrait" inManagedObjectContext:self.manager.managedObjectContext];
            bossTrait.bossTrait_id = @([[dic objectForKey:@"bossTrait_id"] intValue]);
            bossTrait.boss_id = @([[dic objectForKey:@"boss_id"] intValue]);
            bossTrait.describe = [dic objectForKey:@"describe"];
            bossTrait.type = @([[dic objectForKey:@"type"] intValue]);
        }
    }
    [self.manager saveContext];
}

@end
