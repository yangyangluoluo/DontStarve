//
//  QuestionCommentModel.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/28.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Question+CoreDataProperties.h"
#import "QuestionComment+CoreDataProperties.h"
#import "BaseModel.h"

@interface QuestionCommentModel : BaseModel

@property (strong,nonatomic) Question *question;
@property (strong,nonatomic) NSArray *questionComment;

- (instancetype)initWithQuestion:(Question *)question;

@end
