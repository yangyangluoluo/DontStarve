//
//  QuestionCell.h
//  Geological1
//
//  Created by 李建国 on 15/12/27.
//  Copyright © 2015年 李建国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionCell : UICollectionViewCell

@property (strong,nonatomic) UIImageView *portrait;
@property (strong,nonatomic) UILabel  *title;
@property (strong,nonatomic) UILabel  *date;
@property (strong,nonatomic) UILabel  *nickname;
@property (strong,nonatomic) UIView   *line1;
@property (strong,nonatomic) UILabel  *describe;
@property (strong,nonatomic) UIView   *line2;
@property (strong,nonatomic) UILabel  *replyNum;
@property (strong,nonatomic) UIButton *showComments;
@property (strong,nonatomic) UIView   *line3;


@end
