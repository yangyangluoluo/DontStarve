//
//  RegisterView.h
//  Geological
//
//  Created by 李建国 on 15/12/7.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "DLRadioButton.h"
#import <UIKit/UIKit.h>

@interface RegisterView : UIView

@property (strong,nonatomic) UITextField *email;
@property (strong,nonatomic) UILabel *emailState;
@property (strong,nonatomic) UIView *line1;
@property (strong,nonatomic) UITextField *nickname;
@property (strong,nonatomic) UILabel *nicknameState;
@property (strong,nonatomic) UIView *line2;
@property (strong,nonatomic) UITextField *password;
@property (strong,nonatomic) UILabel *passwordState;
@property (strong,nonatomic) UIView *line3;
@property (strong,nonatomic) UITextField *verification;
@property (strong,nonatomic) UILabel *verificationState;
@property (strong,nonatomic) UIView *line4;
@property (strong,nonatomic) UIButton *registerButon;
@property (strong,nonatomic) DLRadioButton *agreeButton;
@property (strong,nonatomic) UILabel *agree;
@property (strong,nonatomic) UIButton *seeAgreement;

- (id)initWithFrame:(CGRect)frame;

@end
