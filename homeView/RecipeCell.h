//
//  RecipeCell.h
//  DontStarve
//
//  Created by 李建国 on 16/1/17.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "FoodRawCell.h"

@interface RecipeCell : FoodRawCell

@property (strong,nonatomic) ImageLabel *cookTime;
@property (strong,nonatomic) UILabel *priority;

@end
