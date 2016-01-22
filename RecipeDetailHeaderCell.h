//
//  RecipeDetailHeaderCell.h
//  DontStarve
//
//  Created by 李建国 on 16/1/22.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "RecipeCell.h"

@interface RecipeDetailHeaderCell : RecipeCell

@property (strong,nonatomic) UIView *bgView;
@property (strong,nonatomic) UILabel *needRaw;
@property (strong,nonatomic) UILabel *needNotRaw;
@property (strong,nonatomic) NSMutableArray *needRawArray;
@property (strong,nonatomic) NSMutableArray *needNotRawArray;

- (void )initNeedRawLabel:(NSUInteger )num;
- (void )defineAllLayout;
- (void )initNeedNotRawLabel:(NSUInteger )num;

@end
