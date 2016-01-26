
//
//  MyADTransition.m
//  Geological
//
//  Created by 李建国 on 15/12/9.
//  Copyright © 2015年 李建国. All rights reserved.
//

#import "MyADTransition.h"

@implementation MyADTransition

+ (ADTransitioningDelegate *)nextTransitionWithFrame:(CGRect )frame{
    static ADTransition *transitionNext = nil;
    static ADTransitioningDelegate *transitionNextDelegate = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        transitionNext = [[ADSwipeFadeTransition alloc] initWithDuration:0.25f orientation:ADTransitionRightToLeft sourceRect:frame];
        transitionNextDelegate = [[ADTransitioningDelegate alloc]initWithTransition:transitionNext];
    });
    return transitionNextDelegate;
}

+ (ADTransitioningDelegate *)blackTransitionWithFrame:(CGRect)frame{
    static ADTransition *transitionBlack = nil;
    static ADTransitioningDelegate *transitionBlackDelegate = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        transitionBlack = [[ADSwipeFadeTransition alloc] initWithDuration:0.25f orientation:ADTransitionLeftToRight sourceRect:frame];
        transitionBlackDelegate = [[ADTransitioningDelegate alloc]initWithTransition:transitionBlack];
    });
    return transitionBlackDelegate;
}

+ (ADTransitioningDelegate *)FilpTransitionWithFrame: (CGRect )frame{
    static ADTransition *transitionFlip = nil;
    static ADTransitioningDelegate *transitionFlipDelegate = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        transitionFlip = [[ADFlipTransition alloc] initWithDuration:0.8f orientation:ADTransitionLeftToRight sourceRect:frame];
        transitionFlipDelegate = [[ADTransitioningDelegate alloc]initWithTransition:transitionFlip];
    });
    return transitionFlipDelegate;
}



@end
