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

@property (strong,nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation QuestionCommentModel

- (instancetype)initWithQuestion:(Question *)question{
    self = [super init];
    if (self) {
        self.question = question;
        [self bindWithReactive];
        [self getFetchResultController];
        self.questionComment = nil;
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"yy年MM月dd日 HH:mm"];
    }
    return self;
}

- (void )bindWithReactive{
    @weakify(self)
    [RACObserve(self.webData, questionComment)  subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allData = x;
        }
    }];
}


- (void )downloadData{
    NSUInteger date = [self getMaxDate];
    if (date == 0) {
        [self.webData downloadQuestionComment:self.question.question_id date:@0];
    }else{
        [self.webData downloadQuestionComment:self.question.question_id date:@(date)];
    }
}


- (NSUInteger )getMaxDate{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"QuestionComment"];
    request.predicate = [NSPredicate predicateWithFormat:@"question_id=%@",self.question.question_id];
    NSArray *comments = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
    if (comments.count == 0) {
        return 0;
    }else{
        NSSet *set = [NSSet setWithArray:comments];
        NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES]];
        NSArray *sortSetArray = [set sortedArrayUsingDescriptors:sortDesc];
        QuestionComment *maxDate = [sortSetArray lastObject];
        return maxDate.date.integerValue;
    }
}

- (NSFetchedResultsController *)getFetchResultController{
    if (self.fetchResultController!=nil) {
        return self.fetchResultController;
    }
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"QuestionComment"];
    request.predicate = [NSPredicate predicateWithFormat:@"question_id=%@",self.question.question_id];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"date" ascending:NO];
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

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.allData) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"questionComment_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"QuestionComment"];
        request.predicate = [NSPredicate predicateWithFormat:@"questionComment_id=%@",theId];
        NSArray *comments = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (comments.count==0) {
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
