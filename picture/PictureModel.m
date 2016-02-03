//
//  PictureModel.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/29.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "PictureUrl+CoreDataProperties.h"
#import "PictureModel.h"
@interface PictureModel()

@end

@implementation PictureModel

- (instancetype )init{
    self = [super init];
    if (self) {
        self.entityname = @"Picture";
        self.entyArr = @"date";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        self.data = nil;
    }
    return self;
}

- (void )getReplyNum:(NSUInteger )row{

    
}

- (void )downloadForUp{
    Picture *pic = [self.manager.fetchResultController.fetchedObjects lastObject];
    NSTimeInterval date;
    if (pic==nil) {
        date = [[NSDate date]timeIntervalSince1970];
    }else{
        date = pic.date.doubleValue;
    }
    NSString *urlStr = [self.webData setUrlString:ALLPICTURE address1:@(date) address2:@(UP)];
    [self downloadAddress:urlStr];
}

- (void )downloadFordown{
    Picture *pic = [self.manager.fetchResultController.fetchedObjects firstObject];
    NSString *urlStr = [self.webData setUrlString:ALLPICTURE address1:pic.date address2:@(DOWN)];
    [self downloadAddress:urlStr];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"picture_id"] intValue]];
        NSString *pridect = @"picture_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]){
            Picture *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:self.entityname inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.picture_id = [NSNumber numberWithInt:[[dic objectForKey:@"picture_id"] intValue]];
            addOneCoreData.theDescribe = [dic objectForKey:@"theDescribe"];
            addOneCoreData.user_name = [dic objectForKey:@"user_name"];
            addOneCoreData.pictureNum = @([[dic objectForKey:@"pictureNum"] intValue]);
            addOneCoreData.commentNum = @([[dic objectForKey:@"commentNum"] intValue]);
            addOneCoreData.date = @([[dic objectForKey:@"date"] doubleValue]);
            NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:[addOneCoreData.date doubleValue]];
            addOneCoreData.dateStr = [self.dateFormatter stringFromDate:date];
            addOneCoreData.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            addOneCoreData.urlStr = [addOneCoreData.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            
            for (NSDictionary *dic2 in (NSArray *)[dic objectForKey:@"picture"]) {
                PictureUrl *need = [NSEntityDescription insertNewObjectForEntityForName:@"PictureUrl" inManagedObjectContext:self.manager.managedObjectContext];
                need.picture_id = @([[dic2 objectForKey:@"picture_id"] intValue]);
                need.pictureUrl_id = @([[dic2 objectForKey:@"pictureUrl_id"] intValue]);
                need.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic2 objectForKey:@"urlStr"]];
                need.urlStr = [need.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
                need.relationship = addOneCoreData;
            }
        }
    }
    [self.manager saveContext];
}

@end
