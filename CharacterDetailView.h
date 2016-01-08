//
//  CharacterDetailView.h
//  DontStarve
//
//  Created by 李建国 on 16/1/7.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "DetailHead.h"
#import <UIKit/UIKit.h>
#import "LabelLineLabel.h"
@interface CharacterDetailView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (strong,nonatomic) DetailHead *header;
@property (strong,nonatomic) LabelLineLabel *unlock;
@property (strong,nonatomic) LabelLineLabel *ability;
@property (strong,nonatomic) LabelLineLabel *introduce;
@property (strong,nonatomic) UIButton *getComments;

@end
