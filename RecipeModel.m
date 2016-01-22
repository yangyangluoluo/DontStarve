//
//  RecipeModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/17.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "RecipeModel.h"
#import "Recipe+CoreDataProperties.h"
@implementation RecipeModel

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
    [RACObserve(self.webData, allRecipe) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allData = x;
        }
    }];
}

- (NSUInteger )getCount{
    return self.fetchResultController.fetchedObjects.count;
}

- (Recipe *)getRecipe:(NSUInteger)row{
    return self.fetchResultController.fetchedObjects[row];
}

- (NSFetchedResultsController *)getFetchResultController{
    if (self.fetchResultController!=nil) {
        return self.fetchResultController;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Recipe"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"recipe_id" ascending:YES];
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
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe" inManagedObjectContext:self.manager.managedObjectContext];
    [req setEntity:entity];
    [req setResultType:NSDictionaryResultType];
    
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"recipe_id"];
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
    [self.webData downloadAllRecipe:@(maxValue)];
}

- (NSNumber *)getMaxId{
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recipe" inManagedObjectContext:self.manager.managedObjectContext];
    [req setEntity:entity];
    [req setResultType:NSDictionaryResultType];
    
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"recipe_id"];
    NSExpression *maxExpression = [NSExpression expressionForFunction:@"max:" arguments:@[keyPathExpression]];
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"maxDisplayOrder"];
    [expressionDescription setExpression:maxExpression];
    [expressionDescription setExpressionResultType:NSInteger32AttributeType];
    [req setPropertiesToFetch:@[expressionDescription]];
    
    NSError *error = nil;
    NSArray *obj = [self.manager.managedObjectContext executeFetchRequest:req error:&error];
    NSInteger maxValue = NSNotFound;
    if(obj == nil){
        return @0;
    }else if([obj count] > 0){
        maxValue = [obj[0][@"maxDisplayOrder"] integerValue];
    }
    return @(maxValue);
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.allData) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"recipe_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Recipe"];
        request.predicate = [NSPredicate predicateWithFormat:@"recipe_id=%@",theId];
        NSArray *coreData = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (coreData.count==0) {
            Recipe *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.recipe_id = [NSNumber numberWithInt:[[dic objectForKey:@"recipe_id"] intValue]];
            addOneCoreData.chName = [dic objectForKey:@"chName"];
            addOneCoreData.enName = [dic objectForKey:@"enName"];
            addOneCoreData.life = @([[dic objectForKey:@"life"] floatValue]);
            addOneCoreData.hunger = @([[dic objectForKey:@"hunger"] floatValue]);
            addOneCoreData.sanity = @([[dic objectForKey:@"sanity"] floatValue]);
            addOneCoreData.badCycle = @([[dic objectForKey:@"badCycle"] floatValue]);
            addOneCoreData.cookTime = @([[dic objectForKey:@"cookTime"] floatValue]);
            addOneCoreData.priority = @([[dic objectForKey:@"priority"] floatValue]);
            addOneCoreData.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            addOneCoreData.urlStr = [addOneCoreData.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
    }
    [self.manager saveContext];
}


@end
