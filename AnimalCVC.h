//
//  AnimalCVC.h
//  DontStarve
//
//  Created by 李建国 on 16/1/8.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "CellProtocol.h"
#import <UIKit/UIKit.h>

@interface AnimalCVC : UICollectionViewController<UICollectionViewDataSource,UICollisionBehaviorDelegate,CellProtocol>

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout;


@end
