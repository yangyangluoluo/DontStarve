//
//  ReplyQuestionVC.h
//  Geological1
//
//  Created by 李建国 on 15/12/27.
//  Copyright © 2015年 李建国. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question+CoreDataProperties.h"

@interface ReplyQuestionVC : UIViewController

@property (strong,nonatomic) NSNumber *state;
- (instancetype)initWithQuestion:(Question *)question;

@end
