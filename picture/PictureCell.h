//
//  PictureCell.h
//  饥荒大事件
//
//  Created by 李建国 on 16/1/29.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureCell : UICollectionViewCell

@property (strong,nonatomic) CALayer *calayer;
@property (strong,nonatomic) UIImageView *portrait;
@property (strong,nonatomic) UILabel *nickname;
@property (strong,nonatomic) UILabel *date;
@property (strong,nonatomic) UILabel *describe;
@property (strong,nonatomic) UIImageView *image1;
@property (strong,nonatomic) UIImageView *image2;
@property (strong,nonatomic) UIImageView *image3;
@property (strong,nonatomic) UIImageView *image4;
@property (strong,nonatomic) UIImageView *image5;
@property (strong,nonatomic) UIImageView *image6;
@property (strong,nonatomic) UIView *line1;
@property (strong,nonatomic) UILabel *commnetNum;
@property (strong,nonatomic) NSArray *images;
@property (strong,nonatomic) UIButton *comment;
@property (strong,nonatomic) UIView *line2;

@end