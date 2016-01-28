//
//  LoginView.h
//  Geological
//
//  Created by 李建国 on 15/12/6.
//  Copyright © 2015年 李建国. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (strong,nonatomic) UIImageView *icon1;
@property (strong,nonatomic) UITextField *nickname;
@property (strong,nonatomic) UILabel *nicknameState;
@property (strong,nonatomic) UIView *line1;
@property (strong,nonatomic) UIImageView *icon2;
@property (strong,nonatomic) UITextField *password;
@property (strong,nonatomic) UILabel *passwordState;
@property (strong,nonatomic) UIView *line2;
@property (strong,nonatomic) UIButton *loginButton;
@property (strong,nonatomic) UIButton *userRegister;
@property (strong,nonatomic) UIColor *color;

- (id)initWithFrame:(CGRect)frame;

@end
