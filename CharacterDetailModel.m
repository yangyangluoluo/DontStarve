//
//  CharacterDetailModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/7.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Characters+CoreDataProperties.h"
#import "CharacterDetailModel.h"
@interface CharacterDetailModel()

@property (strong,nonatomic) NSNumber *characterId;

@end

@implementation CharacterDetailModel

- (instancetype)initWithId:(NSNumber *)characterId{
    self = [super init];
    if (self) {
        self.characterId = characterId;
        [self fetchResultController];
    }
    return self;
}

- (NSString *)getName:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return chartacter.name;
}

- (NSString *)getNickname:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return chartacter.nickname;
}

- (NSString *)getLife:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return chartacter.life;
}

- (NSString *)getHungry:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return chartacter.hungry;
}

- (NSString *)getSanity:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return chartacter.intellect;
}

- (NSString *)getAtk:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return chartacter.atk;
}

- (NSNumber *)getId:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return chartacter.characters_id;
}

- (NSString *)getMotto:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return chartacter.motto;
}

- (NSString *)getUnlock:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return [NSString stringWithFormat:@"    %@",chartacter.unlock];
}
- (NSString *)getAbility:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return [NSString stringWithFormat:@"    %@",chartacter.ability];
}

- (NSString *)getIntroduce:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    
    
    return [NSString stringWithFormat:@"    %@",chartacter.introduction];
}

- (NSString *)getUrlSt:(NSUInteger )index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return [NSString stringWithFormat:@"%@%@",PREFIX,chartacter.urlstr];
}

- (NSFetchedResultsController *)fetchResultController{
    if (_fetchResultController!=nil) {
        return _fetchResultController;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Characters"];
    request.predicate = [NSPredicate predicateWithFormat:@"characters_id=%@",self.characterId];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"characters_id" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    request.sortDescriptors = sortDescriptors;
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.manager.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    _fetchResultController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchResultController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _fetchResultController;
}


@end
