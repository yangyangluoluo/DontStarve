//
//  BaseMateriaCVC.h
//  DontStarve
//
//  Created by 李建国 on 16/1/23.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "CSStickyHeaderFlowLayout.h"
#import "UIImageView+WebCache.h"
#import "Chameleon.h"
#import "ReactiveCocoa.h"
#import "BaseMateriaModel.h"
#import <UIKit/UIKit.h>

@interface BaseMateriaCVC : UICollectionViewController

@property (strong,nonatomic) UIBarButtonItem *leftItem;
@property (strong,nonatomic) UIBarButtonItem *rightItem;
@property (strong,nonatomic) BaseMateriaModel *viewModel;

- (UIBarButtonItem *)leftItem;
- (void)bindWithReactive;
- (void )setImageView:(UIImageView *)view urlStr:(NSString *)urlStr;

@end