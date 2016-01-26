//
//  BaseMateriaModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/23.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BaseMateriaModel.h"

@implementation BaseMateriaModel

- (instancetype )init{
    self = [super init];
    if (self) {
        self.manager = [Manager sharedManager];
        self.webData = [WebData sharedManager];
    }
    return self;
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

- (NSUInteger )getCount{
    return self.fetchResultController.fetchedObjects.count;
}

- (id )getObject:(NSUInteger )index{
    return self.fetchResultController.fetchedObjects[index];
}

- (void )setFectch:(NSString *)entityname sort:(NSString *)sortName{
    if (self.fetchResultController!=nil) {
        return ;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:entityname];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:sortName ascending:YES];
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
}

- (NSUInteger )getMaxId:(NSString *)entityname name:(NSString *)idName{
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityname inManagedObjectContext:self.manager.managedObjectContext];
    [req setEntity:entity];
    [req setResultType:NSDictionaryResultType];
    
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:idName];
    NSExpression *maxExpression = [NSExpression expressionForFunction:@"max:" arguments:@[keyPathExpression]];
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"maxId"];
    [expressionDescription setExpression:maxExpression];
    [expressionDescription setExpressionResultType:NSInteger32AttributeType];
    [req setPropertiesToFetch:@[expressionDescription]];
    
    NSError *error = nil;
    NSArray *obj = [self.manager.managedObjectContext executeFetchRequest:req error:&error];
    NSInteger maxValue = NSNotFound;
    if(obj == nil){
        maxValue = 0;
    }else if([obj count] > 0){
        maxValue = [obj[0][@"maxId"] integerValue];
    }
    return maxValue;
}

@end
