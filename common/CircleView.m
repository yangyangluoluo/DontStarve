//
//  CircleView.m
//  Geological
//
//  Created by 李建国 on 15/12/15.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "ReactiveCocoa.h"
#import "Masonry.h"
#import "Chameleon.h"
#import "CircleView.h"
@interface CircleView()

@property (strong, nonatomic) CAShapeLayer *backgroundLayer;
@property (strong, nonatomic) CAShapeLayer *redLayer;
@property (strong, nonatomic) CAShapeLayer *greenLayer;
@property (strong, nonatomic) CAShapeLayer *yellowLayer;
@property (assign, nonatomic) CGFloat strokeWidth;
@property (nonatomic, strong) UIBezierPath *circlePath;

@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame strokeWidth:(CGFloat)strokeWidth{
    self = [super initWithFrame:frame];
    if (self) {
        self.strokeWidth = strokeWidth;
        self.backgroundColor  = [UIColor whiteColor];
        CGPoint arcCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGFloat radius = CGRectGetMidX(self.bounds) - self.strokeWidth;
        self.circlePath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                         radius:radius
                                                     startAngle:M_PI
                                                       endAngle:-M_PI
                                                      clockwise:NO];
        
        [self.layer addSublayer:[self backgroundLayer]];
        [self.layer addSublayer:[self redLayer]];
        [self.layer addSublayer:[self greenLayer]];
        [self.layer addSublayer:[self yellowLayer]];
        [self updateAnimations];
        [self addSubview:[self addButton]];
    }
    return self;
}

- (CAShapeLayer *)backgroundLayer{
    if (!_backgroundLayer) {
        _backgroundLayer = [CAShapeLayer layer];
        _backgroundLayer.path = self.circlePath.CGPath;
        _backgroundLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _backgroundLayer.fillColor = [UIColor clearColor].CGColor;
        _backgroundLayer.lineWidth = self.strokeWidth;
    }
    return _backgroundLayer;
}

- (CAShapeLayer *)redLayer{
    if (!_redLayer) {
        _redLayer = [CAShapeLayer layer];
        _redLayer.path = self.circlePath.CGPath;
        _redLayer.strokeColor = [UIColor redColor].CGColor;
        _redLayer.fillColor = [UIColor clearColor].CGColor;
        _redLayer.lineWidth = self.strokeWidth;
        _redLayer.strokeStart = 0.f;
        _redLayer.strokeEnd = 0.33f;
    }
    return _redLayer;
}

- (CAShapeLayer *)greenLayer{
    if (!_greenLayer) {
        _greenLayer = [CAShapeLayer layer];
        _greenLayer.path = self.circlePath.CGPath;
        _greenLayer.strokeColor = [UIColor greenColor].CGColor;
        _greenLayer.fillColor = [UIColor clearColor].CGColor;
        _greenLayer.lineWidth = self.strokeWidth;
        _greenLayer.strokeStart = 0.33f;
        _greenLayer.strokeEnd = 0.66f;
    }
    return _greenLayer;
}

- (CAShapeLayer *)yellowLayer{
    if (!_yellowLayer) {
        _yellowLayer = [CAShapeLayer layer];
        _yellowLayer.path = self.circlePath.CGPath;
        _yellowLayer.strokeColor = [UIColor yellowColor].CGColor;
        _yellowLayer.fillColor = [UIColor clearColor].CGColor;
        _yellowLayer.lineWidth = self.strokeWidth;
        _yellowLayer.strokeStart = 0.66f;
        _yellowLayer.strokeEnd = 1.f;
    }
    return _yellowLayer;
}

- (void)updateAnimations{
    CABasicAnimation *strokeEndAnimation = nil;
    strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = 0.8;
    strokeEndAnimation.fromValue = @(_redLayer.strokeStart);
    strokeEndAnimation.toValue = @(_redLayer.strokeEnd);
    strokeEndAnimation.autoreverses = NO;
    strokeEndAnimation.repeatCount = 0.f;
    strokeEndAnimation.removedOnCompletion = NO;
    strokeEndAnimation.delegate = self;
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    [self.redLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
    strokeEndAnimation.fromValue = @(_greenLayer.strokeStart);
    strokeEndAnimation.toValue = @(_greenLayer.strokeEnd);
    [self.greenLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
    strokeEndAnimation.fromValue = @(_yellowLayer.strokeStart);
    strokeEndAnimation.toValue = @(_yellowLayer.strokeEnd);
    [self.yellowLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
}
- (void)restartAnimations{
    [self updateAnimations];
}

- (UIButton *)addButton{
    if (!_addButton) {
        CGRect frame = CGRectMake(self.strokeWidth, self.strokeWidth, self.frame.size.width - 2*self.strokeWidth, self.frame.size.width - 2*self.strokeWidth);
        _addButton = [[UIButton alloc]initWithFrame:frame];
        _addButton.backgroundColor = FlatBlack;
        _addButton.layer.cornerRadius = (self.frame.size.width - 2*self.strokeWidth)/2;
        _addButton.layer.masksToBounds = YES;
    }
    return _addButton;
}

@end
