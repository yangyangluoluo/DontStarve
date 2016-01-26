//
//  BookCell.h
//  DontStarve
//
//  Created by 李建国 on 16/1/26.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "ImageLabel.h"
#import <UIKit/UIKit.h>

@interface BookCell : UICollectionViewCell

@property (strong,nonatomic) UIImageView *image;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) ImageLabel *raw1;
@property (strong,nonatomic) ImageLabel *raw2;
@property (strong,nonatomic) ImageLabel *raw3;
@property (strong,nonatomic) NSArray *raws;
@property (strong,nonatomic) UILabel *oneDescribe;
@property (strong,nonatomic) UILabel *one;

@end
