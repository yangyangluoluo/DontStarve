//
//  CharactersCell.h
//  DontStarve
//
//  Created by 李建国 on 16/1/6.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharactersCell : UICollectionViewCell

@property (strong,nonatomic) UIImageView *image;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *nickname;
@property (strong,nonatomic) UILabel *life;
@property (strong,nonatomic) UILabel *hungry;
@property (strong,nonatomic) UILabel *intellect;
@property (strong,nonatomic) UIView *line1;
@property (strong,nonatomic) UIView *line2;
@property (strong,nonatomic) UIView *line3;
@property (strong,nonatomic) UIView *line4;
@property (strong,nonatomic) UIView *line5;
@property (strong,nonatomic) UIImageView *lifeImage;
@property (strong,nonatomic) UIImageView *hungryImage;
@property (strong,nonatomic) UIImageView *sanityImage;


@end
