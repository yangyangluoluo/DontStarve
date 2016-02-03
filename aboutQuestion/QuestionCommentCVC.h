//
//  QuestionCommentCVC.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/28.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Question+CoreDataProperties.h"
#import "BaseCVC.h"

@interface QuestionCommentCVC : BaseCVC<UICollectionViewDataSource,UICollectionViewDelegate>

- (instancetype )initWithCollectionViewLayout:(UICollectionViewLayout *)layout question:(Question *)question;

@end
