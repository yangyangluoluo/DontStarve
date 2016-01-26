//
//  AnimalCell.h
//  DontStarve
//
//  Created by 李建国 on 16/1/8.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimalCell : UICollectionViewCell

@property (strong,nonatomic) UIImageView *image;
@property (strong,nonatomic) UILabel *chName;
@property (strong,nonatomic) UIView  *line1;
@property (strong,nonatomic) UILabel *enName;
@property (strong,nonatomic) UIView  *line2;
@property (strong,nonatomic) UILabel *type;
@property (strong,nonatomic) UIView  *line3;

@end
