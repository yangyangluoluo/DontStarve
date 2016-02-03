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
        self.entityname = @"Characters";
        self.entyArr = @"characters_id";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        self.data = nil;
    }
    return self;
}

- (void)downloadData{
    Characters *last = self.manager.fetchResultController.fetchedObjects.lastObject;
    NSNumber *index = @0;
    if (last!=nil) {
        index = last.characters_id;
    }
    NSString *urlStr = [self.webData setUrlString:ALLCHARACTERS address1:index];
    [self downloadAddress:urlStr];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"characters_id"] intValue]];
        NSString *pridect = @"characters_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]) {
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
            character.urlstr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlstr"]];
            character.urlstr = [character.urlstr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
    }
    [self.manager saveContext];
}

@end
