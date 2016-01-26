//
//  BossDetailCVC.h
//  DontStarve
//
//  Created by 李建国 on 16/1/13.
//  Copyright © 2016年 李建国. All rights reserved.
//
@class Boss;
#import <UIKit/UIKit.h>

@interface BossDetailCVC : UICollectionViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout boss:(Boss *)theBoss;


@end
