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
        self.data = nil;
    }
    return self;
}

- (void)saveQuetion:(NSString *)describe title:(NSString *)title{
    NSString *name = [self.theUser getName];
    NSMutableDictionary *question = [[NSMutableDictionary alloc]init];
    [question setObject:name forKey:@"name"];
    [question setObject:title forKey:@"title"];
    [question setObject:describe forKey:@"describe"];
    NSString *urlStr = [self.webData setUrlString:ADDQUESTION];
    [self downloadAddress:urlStr information:question];
}

@end
