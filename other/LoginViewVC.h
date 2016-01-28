//
//  LoginViewVC.h
//  Geological
//
//  Created by 李建国 on 15/12/6.
//  Copyright © 2015年 李建国. All rights reserved.
//
@class LoginViewModel;
#import <UIKit/UIKit.h>

@interface LoginViewVC : UIViewController

@property (strong,nonatomic) NSNumber *loginstate;
@property (strong,nonatomic) LoginViewModel *viewModel;

- (instancetype)init;

@end
