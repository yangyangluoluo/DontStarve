//
//  AnimalDetailCVC.h
//  DontStarve
//
//  Created by 李建国 on 16/1/8.
//  Copyright © 2016年 李建国. All rights reserved.
//
@class Animal;
#import "BaseCVC.h"
#import <UIKit/UIKit.h>

@interface AnimalDetailCVC : BaseCVC

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout animal:(Animal *)animal;

@end
