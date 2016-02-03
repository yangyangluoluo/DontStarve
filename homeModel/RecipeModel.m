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
        self.entityname = @"Recipe";
        self.entyArr = @"recipe_id";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        self.data = nil;
    }
    return self;
}

- (void )downloadData{
    Recipe *last = self.manager.fetchResultController.fetchedObjects.firstObject;
    NSNumber *index = @0;
    if (last!=nil) {
        index = last.recipe_id;
    }
    NSString *urlStr = [self.webData setUrlString:ALLRECIPE address1:index];
    [self downloadAddress:urlStr];
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
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"recipe_id"] intValue]];
        NSString *pridect = @"recipe_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]) {
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
            addOneCoreData.urlStr = [addOneCoreData.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
    }
    [self.manager saveContext];
}


@end
