//
//  AddQuestionModel.h
//  Geological1
//
//  Created by 李建国 on 15/12/27.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "BaseModel.h"
#import <Foundation/Foundation.h>

@interface AddQuestionModel : BaseModel

@property (strong,nonatomic) NSDictionary *addQuestionState;
@property (strong,nonatomic) NSNumber *state;
- (void)saveQuetion:(NSString *)describe title:(NSString *)title;

@end
