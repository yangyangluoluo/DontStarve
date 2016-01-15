//
//  CharactersModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/6.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "ReactiveCocoa.h"
#import "BaseModel.h"
#import "CharactersModel.h"

@implementation CharactersModel
- (instancetype)init{
    self = [super init];
    if (self) {
        [self getFetchResultController];
        [self bindWithReactive];
        self.allCharacters = nil;
    }
    return self;
}

- (void)bindWithReactive{
    @weakify(self);
    [RACObserve(self.webData, allCharacters) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allCharacters = x;
        }
    }];
}

- (NSUInteger )getCount{
    return self.fetchResultController.fetchedObjects.count;
}

- (NSString *)getImageUrlStr:(NSUInteger)index{
    Characters *character = self.fetchResultController.fetchedObjects[index];
    NSString *urlStr = character.urlstr;
    return [NSString stringWithFormat:@"%@%@",PREFIX,urlStr];
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
    return [NSString stringWithFormat:@"  %@",chartacter.life];
}

- (NSString *)getHungry:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return [NSString stringWithFormat:@"  %@",chartacter.hungry];
}

- (NSString *)getSanity:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return [NSString stringWithFormat:@"  %@",chartacter.intellect];
}

- (NSNumber *)getId:(NSUInteger)index{
    Characters *chartacter = self.fetchResultController.fetchedObjects[index];
    return chartacter.characters_id;
}


- (NSFetchedResultsController *)getFetchResultController{
    if (self.fetchResultController!=nil) {
        return self.fetchResultController;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Characters"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"characters_id" ascending:YES];
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

- (void)downloadData{
    NSArray *characters = self.fetchResultController.fetchedObjects;
    if (characters.count == 0) {
        [self.webData  downLoadCharactersbyId:[NSNumber numberWithInt:0]];
    }else{
        Characters *character = [characters lastObject];
        [self.webData downLoadCharactersbyId:character.characters_id];
    }
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.allCharacters) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"characters_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Characters"];
        request.predicate = [NSPredicate predicateWithFormat:@"characters_id=%@",theId];
        NSArray *matchInCoreDta = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (matchInCoreDta.count==0) {
            Characters *character = [NSEntityDescription insertNewObjectForEntityForName:@"Characters" inManagedObjectContext:self.manager.managedObjectContext];
            character.characters_id =  [NSNumber numberWithInt:[[dic objectForKey:@"characters_id"] intValue]];
            character.name = [dic objectForKey:@"name"];
            character.nickname = [dic objectForKey:@"nickname"];
            character.intellect = [dic objectForKey:@"intellect"];
            character.life = [dic objectForKey:@"life"];
            character.hungry = [dic objectForKey:@"hungry"];
            character.atk = [dic objectForKey:@"atk"];
            character.motto = [dic objectForKey:@"motto"];
            NSString *ability = [dic objectForKey:@"ability"];
            ability = [ability stringByReplacingOccurrencesOfString:@"CCAVSB" withString:@"\n       "];
            character.ability = ability;
            character.unlock = [dic objectForKey:@"unlock"];
            NSString *introduce = [dic objectForKey:@"introduction"];
            introduce = [introduce stringByReplacingOccurrencesOfString:@"CCAVSB" withString:@"\n       "];
            character.introduction = introduce;
            character.urlstr = [dic objectForKey:@"urlstr"];
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
