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
        self.entityname = @"Animal";
        self.entyArr = @"animal_id";
        [self setFetchResultController];
        self.data = nil;
    }
    return self;
}

- (void )setFetchResultController{

    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Animal"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"animal_id" ascending:YES];
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

- (void)downloadData{
    Animal *animla = self.manager.fetchResultController.fetchedObjects.lastObject;
    NSNumber *index = @0;
    if (animla!=nil) {
        index = animla.animal_id;
    }
    NSString *urlStr = [self.webData setUrlString:ALLANIMAL address1:index];
    [self downloadAddress:urlStr];
}

- (NSUInteger )getFrinedlyCount{
    if ([[self.manager.fetchResultController sections] count]!=0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.manager.fetchResultController sections] objectAtIndex:0];
        return  [sectionInfo numberOfObjects];
    }else{
        return 0;
    }
}

- (NSUInteger )getNeutrallyCount{
    if ([[self.manager.fetchResultController sections] count]!=0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.manager.fetchResultController sections] objectAtIndex:1];
        return  [sectionInfo numberOfObjects];
    }else{
        return 0;
    }
}

- (NSUInteger )getHostilityCount{
    if ([[self.manager.fetchResultController sections] count]!=0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.manager.fetchResultController sections] objectAtIndex:2];
        return  [sectionInfo numberOfObjects];
    }else{
        return 0;
    }
}

- (Animal *)getAnimal:(NSUInteger)section row:(NSUInteger)row{
    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:section];
   return [self.manager.fetchResultController objectAtIndexPath:index];
}

- (void)saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"animal_id"] intValue]];
        NSString *pridect = @"animal_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]) {
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
            animal.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            animal.urlStr = [animal.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
    }
    [self.manager saveContext];
}
@end
