//
//  baseModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/5.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BaseModel.h"
@interface BaseModel ()
@end

@implementation BaseModel

- (instancetype )init{
    self = [super init];
    if (self) {
        self.manager = [Manager sharedManager];
        self.webData = [WebData sharedManager];
        self.theUser = [User sharedManager];
        self.fetchResultController = nil;
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
            self.update = @1;
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

- (NSString *)getName{
    return [self.theUser getName];
}

- (NSNumber *)getRank{
    return [self.theUser getRank];
}

- (NSUInteger )getCount{
    return self.fetchResultController.fetchedObjects.count;
}

- (id )getObjetc:(NSUInteger )row{
    return self.fetchResultController.fetchedObjects[row];
}

- (void )saveName:(NSString *)name rank:(NSNumber *)rank{
    [self.theUser saveName:name];
    [self.theUser saveRank:rank];
    [self.theUser changState];
}
- (NSUInteger )getDate:(NSString *)entityname name:(NSString *)idName direction:(NSString *)direction;{
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityname inManagedObjectContext:self.manager.managedObjectContext];
    [req setEntity:entity];
    [req setResultType:NSDictionaryResultType];
    
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:idName];
//    NSExpression *maxExpression = [NSExpression expressionForFunction:@"max:" arguments:@[keyPathExpression]];
    NSExpression *maxExpression = [NSExpression expressionForFunction:direction arguments:@[keyPathExpression]];
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"theDate"];
    [expressionDescription setExpression:maxExpression];
    [expressionDescription setExpressionResultType:NSInteger32AttributeType];
    [req setPropertiesToFetch:@[expressionDescription]];
    
    NSError *error = nil;
    NSArray *obj = [self.manager.managedObjectContext executeFetchRequest:req error:&error];
    NSInteger maxValue = NSNotFound;
    if(obj == nil){
        maxValue = 0;
    }else if([obj count] > 0){
        maxValue = [obj[0][@"theDate"] integerValue];
    }
    return maxValue;
}

@end
