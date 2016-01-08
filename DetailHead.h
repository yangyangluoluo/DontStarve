//
//  DetailHead.h
//  DontStarve
//
//  Created by 李建国 on 16/1/7.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "ImageLabel.h"
#import <UIKit/UIKit.h>

@interface DetailHead : UIView

@property (strong,nonatomic) UIImageView *image;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *nickname;
@property (strong,nonatomic) ImageLabel *life;
@property (strong,nonatomic) ImageLabel *hungry;
@property (strong,nonatomic) ImageLabel *sanity;
@property (strong,nonatomic) ImageLabel *atk;

@property (strong,nonatomic) UIView *line1;
@property (strong,nonatomic) UIView *line2;
@property (strong,nonatomic) UIView *line3;
@property (strong,nonatomic) UIView *line4;

@property (strong,nonatomic) UILabel *motto;


@end
