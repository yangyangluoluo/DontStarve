//
//  PictureCommentModel.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/30.
//  Copyright © 2016年 李建国. All rights reserved.
//


#import "PictureCommentModel.h"

@interface PictureCommentModel ()
@end

@implementation PictureCommentModel

- (instancetype)initWithPicture:(Picture *)picture{
    self = [super init];
    if (self) {
        self.entityname = @"Comment";
        self.entyArr = @"comment_id";
        self.picture = picture;
        [self initFetchResultController];
        self.data = nil;
    }
    return self;
}

- (void )initFetchResultController{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Comment"];
    request.predicate =[NSPredicate predicateWithFormat:@"primary_id=%@ AND tableName=%@",self.picture.picture_id,@"picture"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    request.sortDescriptors = sortDescriptors;
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.manager.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.manager.fetchResultController = aFetchedResultsController;
    [self.manager setDeletegate];
    
    NSError *error = nil;
    if (![self.manager.fetchResultController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}
- (void )downloadData{
    Comment *comment = self.manager.fetchResultController.fetchedObjects.lastObject;
    NSMutableDictionary *infromation = [[NSMutableDictionary alloc]initWithCapacity:3];
    [infromation setObject:self.picture.picture_id forKey:@"primaryId"];
    [infromation setObject:@"picture" forKey:@"tableName"];
    if (comment==nil) {
        [infromation setObject:@0 forKey:@"date"];
    }else{
        [infromation setObject:comment.date forKey:@"date"];
    }
    NSString *urlStr = [self.webData setUrlString:GETPICCOMMENT];
    [self downloadAddress:urlStr information:infromation];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"comment_id"] intValue]];
        NSString *pridect = @"comment_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]){
            Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:self.entityname inManagedObjectContext:self.manager.managedObjectContext];
            comment.tableName = @"picture";
            comment.primary_id = self.picture.picture_id;
            comment.comment_id = @([[dic objectForKey:@"comment_id"] intValue]);
            comment.user_name = [dic objectForKey:@"user_name"];
            comment.theDescribe =[dic objectForKey:@"theDescribe"];
            comment.date = @([[dic objectForKey:@"date"] doubleValue]);
            NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:[comment.date doubleValue]];
            comment.dateStr = [self.dateFormatter stringFromDate:date];
            comment.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            comment.urlStr = [comment.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
    }
    [self.manager saveContext];
}

@end
