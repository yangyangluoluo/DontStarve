//
//  QuestionModel.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/27.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "QuestionModel.h"
#import "Question+CoreDataProperties.h"

@interface QuestionModel()

@property (strong,nonatomic) NSDateFormatter *dateFormatter;
@property (assign,nonatomic) Question *setReplyNum;

@end

@implementation QuestionModel

- (instancetype )init{
    self = [super init];
    if (self) {
        [self getFetchResultController];
        [self bindWithReactive];
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"yy年MM月dd日 HH:mm"];
        self.data =nil;
    }
    return self;
}

- (void )bindWithReactive{
    @weakify(self);
    [RACObserve(self.theUser, state) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
          self.data = x;
        }
    }];
    [RACObserve(self.webData, allQuestion) subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x) {
            self.allData = x;
        }
    }];
    [RACObserve(self.webData, questionReply) subscribeNext:^(NSDictionary *x) {
        @strongify(self);
        if (x) {
            NSNumber *num = @([[x objectForKey:@"replys"] intValue]);
            self.setReplyNum.replys = num;
            [self.manager saveContext];
        }
    }];
}

- (void )getReplyNum:(NSUInteger )row{
    self.setReplyNum = self.fetchResultController.fetchedObjects[row];
    [self.webData downloadQuestionReply:self.setReplyNum.question_id];
    
}

- (BOOL )getLoginState{
    NSString *name = [self.theUser getName];
    if (name==nil) {
        return NO;
    }else{
        return YES;
    }
}

- (NSFetchedResultsController *)getFetchResultController{
  if (self.fetchResultController!=nil) {
    return self.fetchResultController;
  }
  NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Question"];
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

- (Question *)getQuestion:(NSUInteger )row{
    return self.fetchResultController.fetchedObjects[row];
}
- (void )downloadForUp{
    NSUInteger minDate = [self getDate:@"Question" name:@"date" direction:@"min:"];
    if (minDate==0) {
        NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
        [self.webData downloadAllQuestion:@(now) direction:@(UP)];
    }else{
        [self.webData downloadAllQuestion:@(minDate) direction:@(UP)];
    }
}

- (void )downloadFordown{
    NSUInteger maxDate = [self getDate:@"Question" name:@"date" direction:@"max:"];
    [self.webData downloadAllQuestion:@(maxDate) direction:@(DOWN)];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.allData) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"question_id"] intValue]];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Question"];
        request.predicate = [NSPredicate predicateWithFormat:@"question_id=%@",theId];
        NSArray *coreData = [self.manager.managedObjectContext executeFetchRequest:request error:nil];
        if (coreData.count==0) {
            Question *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Question" inManagedObjectContext:self.manager.managedObjectContext];
            addOneCoreData.question_id = [NSNumber numberWithInt:[[dic objectForKey:@"question_id"] intValue]];
            addOneCoreData.title = [dic objectForKey:@"title"];
            addOneCoreData.user_name = [dic objectForKey:@"user_name"];
            addOneCoreData.theDescribe = [dic objectForKey:@"theDescribe"];
            addOneCoreData.date   = @([[dic objectForKey:@"date"] doubleValue]);
            NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:[addOneCoreData.date doubleValue]];
            addOneCoreData.dateStr = [self.dateFormatter stringFromDate:date];

            addOneCoreData.replys = @([[dic objectForKey:@"replys"] intValue]);
            addOneCoreData.urlStr = [NSString  stringWithFormat:@"%@%@",PREFIX,[dic objectForKey:@"urlStr"]];
            addOneCoreData.urlStr = [addOneCoreData.urlStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
    }
    [self.manager saveContext];
}

@end
