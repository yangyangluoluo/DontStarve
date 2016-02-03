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

@property (assign,nonatomic) Question *setReplyNum;

@end

@implementation QuestionModel

- (instancetype )init{
    self = [super init];
    if (self) {
        self.entityname = @"Question";
        self.entyArr = @"date";
        [self.manager initFecthResultByName:self.entityname attribute:self.entyArr];
        [self bindWithReactive];
        self.data = nil;
        self.data1 = nil;
    }
    return self;
}

- (void )bindWithReactive{
    @weakify(self);
    [RACObserve(self, data1) subscribeNext:^(NSDictionary *x) {
        @strongify(self);
        if (x) {
            NSNumber *num = @([[x objectForKey:@"replys"] intValue]);
            if (num.intValue!=self.setReplyNum.replys.intValue) {
                self.setReplyNum.replys = num;
                [self.manager saveContext];
            }
        }
    }];
}

- (void )getReplyNum:(NSUInteger )row{
    self.setReplyNum = self.manager.fetchResultController.fetchedObjects[row];
    NSString *urlStr = [self.webData setUrlString:QUESTIONREPLY address1:self.setReplyNum.question_id];
    [self downloadAddress1:urlStr];
}

- (void )downloadForUp{
    Question *question = self.manager.fetchResultController.fetchedObjects.lastObject;
    NSTimeInterval date;
    if (question==nil) {
        date = [[NSDate date]timeIntervalSince1970];
    }else{
        date = question.date.doubleValue;
    }
    NSString *urlStr = [self.webData setUrlString:ALLQUESTION address1:@(date) address2:@(UP)];
    [self downloadAddress:urlStr];
}

- (void )downloadFordown{
    Question *question = self.manager.fetchResultController.fetchedObjects.firstObject;
    NSString *urlStr = [self.webData setUrlString:ALLQUESTION address1:question.question_id address2:@(DOWN)];
    [self downloadAddress:urlStr];
}

- (void )saveDataToCoreData{
    for (NSDictionary *dic in self.data) {
        NSNumber *theId = [NSNumber numberWithInt:[[dic objectForKey:@"question_id"] intValue]];
        NSString *pridect = @"question_id=%@";
        if (![self.manager entityExist:self.entityname attribute:pridect entityId:theId]){
            Question *addOneCoreData = [NSEntityDescription insertNewObjectForEntityForName:self.entityname inManagedObjectContext:self.manager.managedObjectContext];
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
