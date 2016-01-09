//
//  AnimalModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/8.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "ReactiveCocoa.h"
#import "AnimalModel.h"
#import "Animal+CoreDataProperties.h"
@implementation AnimalModel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self getFetchResultController];
        [self bindWithReactive];
        self.allAnimal = nil;
    }
    return self;
}

- (void)bindWithReactive{
    @weakify(self);
    [RACObserve(self.webData, allAnimal) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allAnimal = x;
        }
    }];
}

- (NSFetchedResultsController *)getFetchResultController{
    if (self.fetchResultController!=nil) {
        return self.fetchResultController;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Animal"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"animal_id" ascending:YES];
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

- (void)downloadData{
    NSArray *animlas = self.fetchResultController.fetchedObjects;
    if (animlas.count == 0) {
        [self.webData  downloadAnimal:@0];
    }else{
        Animal *animal = [animlas lastObject];
        [self.webData downloadAnimal:animal.animal_id];
    }
}

- (NSUInteger )getFrinedlyCount{
    if ([[self.fetchResultController sections] count]!=0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchResultController sections] objectAtIndex:0];
        return  [sectionInfo numberOfObjects];
    }else{
        return 0;
    }
}

- (NSUInteger )getNeutrallyCount{
    if ([[self.fetchResultController sections] count]!=0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchResultController sections] objectAtIndex:1];
        return  [sectionInfo numberOfObjects];
    }else{
        return 0;
    }
}

- (NSUInteger )getHostilityCount{
    if ([[self.fetchResultController sections] count]!=0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchResultController sections] objectAtIndex:2];
        return  [sectionInfo numberOfObjects];
    }else{
        return 0;
    }
}

- (NSString *)getChName:(NSUInteger)section row:(NSUInteger)row{
    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:section];
    Animal *animal = [self.fetchResultController objectAtIndexPath:index];
    return animal.chName;
}

- (NSString *)getEnName:(NSUInteger)section row:(NSUInteger)row{
    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:section];
    Animal *animal = [self.fetchResultController objectAtIndexPath:index];
    return animal.enName;
}

- (NSString *)getImageUrlStr:(NSUInteger)section row:(NSUInteger)row{
    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:section];
    Animal *animal = [self.fetchResultController objectAtIndexPath:index];
    return [NSString stringWithFormat:@"%@%@",PREFIX,animal.urlStr];
}

- (Animal *)getAnimal:(NSUInteger)section row:(NSUInteger)row{
    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:section];
   return [self.fetchResultController objectAtIndexPath:index];
}

- (void)saveDataToCoreData{
    for (NSDictionary *dic in self.allAnimal) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"animal_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Animal"];
        request.predicate = [NSPredicate predicateWithFormat:@"animal_id=%@",theId];
        NSArray *animals = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (animals.count==0) {
            Animal *animal = [NSEntityDescription insertNewObjectForEntityForName:@"Animal" inManagedObjectContext:self.manager.managedObjectContext];
            animal.animal_id = [NSNumber numberWithInt:[[dic objectForKey:@"animal_id"] intValue]];
            animal.chName = [dic objectForKey:@"chName"];
            animal.enName = [dic objectForKey:@"enName"];
            animal.type = [NSNumber numberWithInt:[[dic objectForKey:@"type"] intValue]];
            animal.atktype = [dic objectForKey:@"atktype"];
            animal.life = [dic objectForKey:@"life"];
            animal.atk = [dic objectForKey:@"atk"];
            animal.atkPeriod = [dic objectForKey:@"atkPeriod"];
            animal.wit = [dic objectForKey:@"wit"];
            animal.walkingSpeed = [dic objectForKey:@"walkingSpeed"];
            animal.runSpeed = [dic objectForKey:@"runSpeed"];
            animal.loot = [dic objectForKey:@"loot"];
            animal.attractFood = [dic objectForKey:@"attractFood"];
            animal.bornRegion = [dic objectForKey:@"bornRegion"];
            animal.remark = [dic objectForKey:@"remark"];
            animal.urlStr = [dic objectForKey:@"urlStr"];
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
