//
//  BookModel.m
//  DontStarve
//
//  Created by 李建国 on 16/1/26.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "BookModel.h"
#import "Book+CoreDataProperties.h"
#import "MixNeed+CoreDataProperties.h"
@implementation BookModel

- (instancetype )init{
    self = [super init];
    if (self) {
        self.entityname = @"Book";
        self.entyArr = @"book_id";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        self.data = nil;
    }
    return self;
}

- (void )downloadData{
    
    Book *last = self.manager.fetchResultController.fetchedObjects.lastObject;
    NSNumber *index = @0;
    if (last!=nil) {
        index = last.book_id;
    }
    NSString *urlStr = [self.webData setUrlString:ALLBOOK address1:index];
    [self downloadAddress:urlStr];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"book_id"] intValue]];
        NSString *pridect = @"book_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]) {
            Book *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.book_id = [NSNumber numberWithInt:[[dic objectForKey:@"book_id"] intValue]];
            addOneCoreData.name = [dic objectForKey:@"name"];
            addOneCoreData.describe = [dic objectForKey:@"describe"];
            addOneCoreData.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            addOneCoreData.urlStr = [addOneCoreData.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            
            for (NSDictionary *dic2 in (NSArray *)[dic objectForKey:@"mixNeed"]) {
                MixNeed *need = [NSEntityDescription insertNewObjectForEntityForName:@"MixNeed" inManagedObjectContext:self.manager.managedObjectContext];
                need.mixNeed_id = @([[dic2 objectForKey:@"mixNeed_id"] intValue]);
                need.num = @([[dic2 objectForKey:@"num"] floatValue]);
                need.name = [dic2 objectForKey:@"name"];
                need.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic2 objectForKey:@"urlStr"]];
                need.urlStr = [need.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
                need.relationship8 = addOneCoreData;
            }
        }
    }
    [self.manager saveContext];
}

@end
