//
//  QuestionCommentModel.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/28.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "QuestionComment+CoreDataProperties.h"
#import "QuestionCommentModel.h"

@interface QuestionCommentModel ()
@end

@implementation QuestionCommentModel

- (instancetype)initWithQuestion:(Question *)question{
    self = [super init];
    if (self) {
        self.question = question;
        self.entityname = @"QuestionComment";
        self.entyArr = @"date";
        [self initFetchResultComtroller];
        self.data = nil;
    }
    return self;
}

- (void )downloadData{
    QuestionComment *comment = self.manager.fetchResultController.fetchedObjects.firstObject;
    NSTimeInterval date;
    if (comment==nil) {
        date = 0.0f;
    }else{
        date = comment.date.doubleValue;
    }
    NSString *urlStr = [self.webData setUrlString:QUESTIONCOMMENT address1:self.question.question_id address2:@(date)];
    [self downloadAddress:urlStr];
}

- (void )initFetchResultComtroller{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:self.entityname];
    request.predicate = [NSPredicate predicateWithFormat:@"question_id=%@",self.question.question_id];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:self.entyArr ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    request.sortDescriptors = sortDescriptors;
    
    [self.manager initFetchResultByRequest:request];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"questionComment_id"] intValue]];
        NSString *pridect = @"questionComment_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]){
            QuestionComment *comment = [NSEntityDescription insertNewObjectForEntityForName:@"QuestionComment" inManagedObjectContext:self.manager.managedObjectContext];
            comment.questionComment_id = @([[dic objectForKey:@"questionComment_id"] intValue]);
            comment.question_id = @([[dic objectForKey:@"question_id"] intValue]);
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
