//
//  MyADTransition.h
//  Geological
//
//  Created by 李建国 on 15/12/9.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "ADTransitionController.h"
#import <Foundation/Foundation.h>

@interface MyADTransition : NSObject

+ (ADTransitioningDelegate *)nextTransitionWithFrame: (CGRect )frame;
+ (ADTransitioningDelegate *)blackTransitionWithFrame:(CGRect )frame;
+ (ADTransitioningDelegate *)FilpTransitionWithFrame: (CGRect )frame;

@end
