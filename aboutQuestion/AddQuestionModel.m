//
//  AddQuestionModel.m
//  Geological1
//
//  Created by 李建国 on 15/12/27.
//  Copyright © 2015年 李建国. All rights reserved.
//

#import "AddQuestionModel.h"

@interface AddQuestionModel ()

@end

@implementation AddQuestionModel

- (id)init{
    self = [super init];
    if (self) {
        [self bindWithReactive];
        self.addQuestionState = nil;
    }
    return self;
}

- (void)bindWithReactive{
    @weakify(self)
    [RACObserve(self.webData, addQuestionState)  subscribeNext:^(NSDictionary *x) {
        @strongify(self);
        if (x) {
            self.addQuestionState = x;
        }
    }];
    [RACObserve(self.theUser, state) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x) {
            self.state = x;
        }
    }];
}

- (void)saveQuetion:(NSString *)describe title:(NSString *)title{
    NSString *name = [self.theUser getName];
    NSMutableDictionary *question = [[NSMutableDictionary alloc]init];
    [question setObject:name forKey:@"name"];
    [question setObject:title forKey:@"title"];
    [question setObject:describe forKey:@"describe"];
    [self.webData addQuestion:question];
}

@end
