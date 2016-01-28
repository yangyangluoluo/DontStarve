//
//  ReplyQuestionModel.m
//  Geological1
//
//  Created by 李建国 on 15/12/27.
//  Copyright © 2015年 李建国. All rights reserved.
//

#import "ReplyQuestionModel.h"
#import "WebData.h"


@interface ReplyQuestionModel ()
@end

@implementation ReplyQuestionModel

- (instancetype)initWithQuestion:(Question *)question{
    self = [super init];
    if (self) {
        self.question = question;
        [self bindWithReactive];
        self.commentQuestion = nil;
    }
    return self;
}

- (void)bindWithReactive{
    @weakify(self)
    [RACObserve(self.webData, commentQuestion)  subscribeNext:^(NSDictionary *x) {
        @strongify(self);
        if (x) {
            self.commentQuestion = x;
        }
    }];
    
    [RACObserve(self.theUser, state) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x) {
            self.state = x;
        }
    }];
}

- (void) saveQuestionComment:(NSString *)describe{
    NSString *name = [self.theUser getName];
    NSMutableDictionary *comment = [[NSMutableDictionary alloc]init];
    [comment setObject:name forKey:@"name"];
    [comment setObject:describe forKey:@"describe"];
    [comment setObject:self.question.question_id forKey:@"question_id"];
    [self.webData commentQuestion:comment];
}












@end
