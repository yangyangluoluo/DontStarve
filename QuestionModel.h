//
//  QuestionModel.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/27.
//  Copyright © 2016年 李建国. All rights reserved.
//
@class Question;
#import "BaseModel.h"

@interface QuestionModel : BaseModel

@property (strong,nonatomic) NSArray *data;

- (void )downloadForUp;
- (void )downloadFordown;
- (BOOL )getLoginState;
- (Question *)getQuestion:(NSUInteger )row;
- (void )getReplyNum:(NSUInteger )row;


@end
