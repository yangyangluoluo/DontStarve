//
//  FoodRawCell.h
//  DontStarve
//
//  Created by 李建国 on 16/1/15.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "ImageLabel.h"
#import <UIKit/UIKit.h>

@interface FoodRawCell : UICollectionViewCell

@property (strong,nonatomic)UIImageView *image;
@property (strong,nonatomic)UILabel *chName;
@property (strong,nonatomic)UILabel *edibleMethod;
@property (strong,nonatomic)ImageLabel *life;
@property (strong,nonatomic)ImageLabel *hunger;
@property (strong,nonatomic)ImageLabel *sanity;
@property (strong,nonatomic)ImageLabel *badCycle;

- (ImageLabel *)getImageLabel;
@end
