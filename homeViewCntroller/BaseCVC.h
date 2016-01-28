//
//  BaseCVC.h
//  DontStarve
//
//  Created by 李建国 on 16/1/17.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "MJRefreshAutoNormalFooter.h"
#import "CSStickyHeaderFlowLayout.h"
#import "UIImageView+WebCache.h"
#import "Chameleon.h"
#import "ReactiveCocoa.h"
#import "BaseModel.h"
#import <UIKit/UIKit.h>

@interface BaseCVC : UICollectionViewController

@property (strong,nonatomic) UIBarButtonItem *leftItem;
@property (strong,nonatomic) UIBarButtonItem *rightItem;


- (UIBarButtonItem *)leftItem;
- (UIBarButtonItem *)rightItem;

@end
