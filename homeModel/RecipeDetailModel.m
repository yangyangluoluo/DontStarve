//
//  RecipeDetailModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/21.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Recipe+CoreDataProperties.h"
#import "RecipeDetailModel.h"
#import "RecipeDetail+CoreDataProperties.h"
@interface RecipeDetailModel()

@property (strong,nonatomic) NSNumber *recipeId;
@property (strong,nonatomic) NSString *recipeName;

@end

@implementation RecipeDetailModel

- (instancetype )initWithRecipe:(NSNumber *)recipeId andName:(NSString *)recipeName{
    self = [super init];
    if (self) {
        self.recipeId = recipeId;
        self.recipeName =recipeName;
        self.data = nil;
        self.data1 = nil;
    }
    return self;
}

- (void )initFetchRecipeRaw{
    if (self.fetchRecipeRaw!=nil) {
        return;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"RecipeRaw"];
    request.predicate = [NSPredicate predicateWithFormat:@"recipe_id =%@",self.recipeId];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc]initWithKey:@"needtype" ascending:NO];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc]initWithKey:@"recipeRaw_id" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor1,sortDescriptor2];
    request.sortDescriptors = sortDescriptors;
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.manager.managedObjectContext sectionNameKeyPath:@"needtype" cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    self.fetchRecipeRaw = aFetchedResultsController;
    NSError *error = nil;
    if (![self.fetchRecipeRaw performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void )initFetchRecipeDetail{
    if (self.fetchRecipeDetail!=nil) {
        return;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"RecipeDetail"];
    request.predicate = [NSPredicate predicateWithFormat:@"recipeName = %@",self.recipeName];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"recipeDetail_id" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    request.sortDescriptors = sortDescriptors;
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.manager.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    self.fetchRecipeDetail = aFetchedResultsController;
    NSError *error = nil;
    if (![self.fetchRecipeDetail performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void )downloadData{
    [self initFetchRecipeRaw];
    RecipeRaw *raw = self.fetchRecipeRaw.fetchedObjects.lastObject;
    if (raw==nil) {
        NSString *url = [self.webData setUrlString:RECIPERAW address1:self.recipeId];
        [self downloadAddress:url];
    }
    
    [self initFetchRecipeDetail];
    RecipeDetail *detail = self.fetchRecipeDetail.fetchedObjects.lastObject;
    if (detail==nil) {
        NSString *url1 = [self.webData setUrlString:RECIPEDETAIL address1:self.recipeName];
        [self downloadAddress1:url1];
    }
}

- (NSUInteger )getCount{
    return self.fetchRecipeDetail.fetchedObjects.count;
}

- (RecipeDetail *)getDetail:(NSUInteger)row{
    return self.fetchRecipeDetail.fetchedObjects[row];
}

- (NSUInteger )getNeedRawNum{
    if ([[self.fetchRecipeRaw sections] count]>0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchRecipeRaw sections] objectAtIndex:0];
        return  [sectionInfo numberOfObjects];
    }else{
        return 0;
    }
}

- (NSUInteger )getNeedNotRawNum{
    if ([[self.fetchRecipeRaw sections] count]>1) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchRecipeRaw sections] objectAtIndex:1];
        return  [sectionInfo numberOfObjects];
    }else{
        return 0;
    }
}

- (RecipeRaw *)getRecipeRaw:(NSUInteger)section andRow:(NSUInteger)row{
    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:section];
    return [self.fetchRecipeRaw objectAtIndexPath:index];
}

- (void)saveRecipeRawToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"recipeRaw_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"RecipeRaw"];
        request.predicate = [NSPredicate predicateWithFormat:@"recipeRaw_id=%@",theId];
        NSArray *coreData = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (coreData.count==0) {
            RecipeRaw *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"RecipeRaw" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.recipe_id = @([[dic objectForKey:@"recipe_id"] intValue]);
            addOneCoreData.recipeRaw_id = @([[dic objectForKey:@"recipeRaw_id"] intValue]);
            addOneCoreData.needtype = @([[dic objectForKey:@"needtype"] boolValue]);
            addOneCoreData.needNum = @([[dic objectForKey:@"needNum"] floatValue]);
            addOneCoreData.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            addOneCoreData.urlStr = [addOneCoreData.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
    }
    [self.manager saveContext];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data1) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"recipeDetail_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"RecipeDetail"];
        request.predicate = [NSPredicate predicateWithFormat:@"recipeDetail_id=%@",theId];
        NSArray *coreData = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (coreData.count==0) {
            RecipeDetail *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"RecipeDetail" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.recipeDetail_id = [NSNumber numberWithInt:[[dic objectForKey:@"recipeDetail_id"] intValue]];
            addOneCoreData.recipeName = [dic objectForKey:@"recipeName"];
            addOneCoreData.raw1 = [dic objectForKey:@"raw1"];
            addOneCoreData.raw2 = [dic objectForKey:@"raw2"];
            addOneCoreData.raw3 = [dic objectForKey:@"raw3"];
            addOneCoreData.raw4 = [dic objectForKey:@"raw4"];
            
            addOneCoreData.raw1UrlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"raw1UrlStr"]];
            addOneCoreData.raw1UrlStr = [addOneCoreData.raw1UrlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            addOneCoreData.raw2UrlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"raw2UrlStr"]];
            addOneCoreData.raw2UrlStr = [addOneCoreData.raw2UrlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            addOneCoreData.raw3UrlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"raw3UrlStr"]];
            addOneCoreData.raw3UrlStr = [addOneCoreData.raw3UrlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            addOneCoreData.raw4UrlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"raw4UrlStr"]];
            addOneCoreData.raw4UrlStr = [addOneCoreData.raw4UrlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
    }
    [self.manager saveContext];
}

- (void )controller:(NSFetchedResultsController *)controller
    didChangeObject:(id)anObject
        atIndexPath:(NSIndexPath *)indexPath
      forChangeType:(NSFetchedResultsChangeType)type
       newIndexPath:(NSIndexPath *)newIndexPath {
    switch(type) {
        case NSFetchedResultsChangeInsert:{
            self.manager.reload = @1;
            break;
        }
        case NSFetchedResultsChangeDelete:{
            
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            self.manager.update = @1;
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
