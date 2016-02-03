//
//  CircleView.h
//  Geological
//
//  Created by 李建国 on 15/12/15.
//  Copyright © 2015年 李建国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

@property (strong,nonatomic) UIButton *addButton;

- (instancetype)initWithFrame:(CGRect)frame strokeWidth:(CGFloat)strokeWidth;
- (void)restartAnimations;

@end
