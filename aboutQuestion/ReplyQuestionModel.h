//
//  ReplyQuestionModel.h
//  Geological1
//
//  Created by 李建国 on 15/12/27.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "Question+CoreDataProperties.h"
#import "BaseModel.h"
#import <Foundation/Foundation.h>

@interface ReplyQuestionModel : BaseModel

@property (strong,nonatomic) Question *question;

- (instancetype)initWithQuestion:(Question *)question;
- (void) saveQuestionComment:(NSString *)describe;

@end
