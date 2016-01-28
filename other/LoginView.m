//
//  LoginView.m
//  Geological
//
//  Created by 李建国 on 15/12/6.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "ReactiveCocoa.h"
#import "LoginView.h"
#import "Masonry.h"
#import "Chameleon.h"

@implementation LoginView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = [UIColor colorWithRed:0.20f green:0.83f blue:1.00f alpha:1.00f];
        [self addViews];
        [self defineLayout];
    }
    return self;
}
- (void)addViews{
    [self  addSubview:[self icon1]];
    [self  addSubview:[self nickname]];
    [self  addSubview:[self nicknameState]];
    [self  addSubview:[self line1]];
    [self  addSubview:[self icon2]];
    [self  addSubview:[self password]];
    [self  addSubview:[self passwordState]];
    [self  addSubview:[self line2]];
    [self  addSubview:[self loginButton]];
    [self  addSubview:[self userRegister]];
}

- (void)defineLayout{
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(145);
        make.width.mas_equalTo(self.frame.size.width*0.6);
        make.height.mas_equalTo(1);
    }];
    
    [self.icon1 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(self.line1.mas_left);
        make.bottom.mas_equalTo(self.line1.mas_top).offset(-10);
    }];
    
    [self.nickname mas_makeConstraints:^(MASConstraintMaker *make) {
   
        make.left.mas_equalTo(self.icon1.mas_right).offset(10);
        make.centerY.mas_equalTo(self.icon1);
        make.width.mas_equalTo(self.line1);
    }];
    
    [self.nicknameState mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(self.line1.mas_right);
        make.centerY.mas_equalTo(self.nickname);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.mas_equalTo(self.line1);
        make.bottom.mas_equalTo(self.line1).offset(40);
        make.width.mas_equalTo(self.frame.size.width*0.6);
        make.height.mas_equalTo(1);
        
    }];
    
    [self.icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
     
        make.left.mas_equalTo(self.line1.mas_left);
        make.bottom.mas_equalTo(self.line2.mas_top).offset(-10);
    }];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.mas_equalTo(self.nickname.mas_left);
        make.bottom.mas_equalTo(self.line2.mas_top);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.line2);
    }];
    
    [self.passwordState mas_makeConstraints:^(MASConstraintMaker *make) {
   
        make.left.mas_equalTo(self.line2.mas_right);
        make.centerY.mas_equalTo(self.password);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line2.mas_bottom).offset(40);
        make.centerX.mas_equalTo(self.line2);
        make.width.mas_equalTo(self.line2);
        make.height.mas_equalTo(40);
    }];
    
    [self.userRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.loginButton.mas_right);
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(40);
    }];
}

- (UIImageView *)icon1{
    if (!_icon1) {
        _icon1 = [UIImageView new];
        _icon1.image = [UIImage imageNamed:@"user"];
    }
    return _icon1;
}

- (UITextField *)nickname{
    if (!_nickname) {
        _nickname = [UITextField new];
        _nickname.textAlignment = NSTextAlignmentLeft;
        _nickname.font = [UIFont systemFontOfSize:14];
        _nickname.clearsOnBeginEditing = YES;
        _nickname.placeholder = @"输入帐号";
    }
    return _nickname;
}

- (UILabel *)nicknameState{
    if (!_nicknameState) {
        _nicknameState = [[UILabel alloc]init];
        _nicknameState.font = [UIFont systemFontOfSize:10];
        _nicknameState.text = @"不正确";
    }
    return _nicknameState;
}


- (UIView *)line1{
    if (!_line1) {
        _line1 = [UIView new];
        _line1.backgroundColor = [UIColor lightGrayColor];
    }
    return _line1;
}

- (UIImageView *)icon2{
    if (!_icon2) {
        _icon2 = [UIImageView new];
        _icon2.image = [UIImage imageNamed:@"password"];
    }
    return _icon2;
}

- (UITextField *)password{
    if (!_password) {
        _password = [UITextField new];
        _password.textAlignment = NSTextAlignmentLeft;
        _password.font = [UIFont systemFontOfSize:14];
        _password.placeholder = @"输入密码";
        _password.secureTextEntry = YES;
    }
    return _password;
}

- (UILabel *)passwordState{
    if (!_passwordState) {
        _passwordState = [[UILabel alloc]init];
        _passwordState.font = [UIFont systemFontOfSize:10];
        _passwordState.text = @"不正确";
    }
    return _passwordState;
}

- (UIView *)line2{
    if (!_line2) {
        _line2 = [UIView new];
        _line2.backgroundColor = [UIColor lightGrayColor];
    }
    return _line2;
}

- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton new];
        _loginButton.titleLabel.font =[UIFont systemFontOfSize:18];
        _loginButton.backgroundColor = [UIColor grayColor];
       [_loginButton setBackgroundImage:[UIImage imageNamed:@"bgButton"] forState:UIControlStateNormal];
       [_loginButton setTitle:@"登  录" forState:UIControlStateNormal];
       [_loginButton setTitle:@"格式错误" forState:UIControlStateDisabled];
    }
    return _loginButton;
}

- (UIButton *)userRegister{
    if (!_userRegister) {
        _userRegister = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_userRegister setTitle:@"注册" forState:UIControlStateNormal];
        _userRegister.titleLabel.font = [UIFont systemFontOfSize:18];
        _userRegister.tintColor = self.color;
    }
    return _userRegister;
}


@end
