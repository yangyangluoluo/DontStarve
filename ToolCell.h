//
//  ToolCell.h
//  DontStarve
//
//  Created by 李建国 on 16/1/23.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "ImageLabel.h"
#import <UIKit/UIKit.h>

@interface ToolCell : UICollectionViewCell

@property (strong,nonatomic) UIImageView *image;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) ImageLabel *raw1;
@property (strong,nonatomic) ImageLabel *raw2;
@property (strong,nonatomic) ImageLabel *raw3;
@property (strong,nonatomic) UILabel *oneDescribe;
@property (strong,nonatomic) UILabel *one;
@property (strong,nonatomic) UILabel *twoDescribe;
@property (strong,nonatomic) UILabel *two;
@property (strong,nonatomic) UILabel *threeDescribe;
@property (strong,nonatomic) UILabel *three;
@property (strong,nonatomic) UILabel *fourDescribe;
@property (strong,nonatomic) UILabel *four;
@property (strong,nonatomic) NSArray *raws;

- (UILabel *)getLabel;
- (UILabel *)getDescribLabel;

@end
