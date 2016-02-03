//
//  RegisterView.m
//  Geological
//
//  Created by 李建国 on 15/12/7.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "Masonry.h"
#import "RegisterView.h"

@implementation RegisterView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self defineLayout];
    }
    return self;
}

- (void) addViews{
    [self addSubview:[self email]];
    [self addSubview:[self emailState]];
    [self addSubview:[self line1]];
    [self addSubview:[self nickname]];
    [self addSubview:[self nicknameState]];
    [self addSubview:[self line2]];
    [self addSubview:[self password]];
    [self addSubview:[self passwordState]];
    [self addSubview:[self line3]];
    [self addSubview:[self verification]];
    [self addSubview:[self verificationState]];
    [self addSubview:[self line4]];
    [self addSubview:[self registerButon]];
    [self addSubview:[self agreeButton]];
    [self addSubview:[self agree]];
    [self addSubview:[self seeAgreement]];
}

- (void)defineLayout{
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(120);
        make.width.mas_equalTo(self.frame.size.width*0.6);
        make.height.mas_equalTo(1);
    }];
    
    [self.email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.line1.mas_top).offset(-5);
        make.left.equalTo(self.line1.mas_left);
        make.width.mas_equalTo(self.line1);
    }];
    
    [self.emailState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.email.mas_right);
        make.centerY.mas_equalTo(self.email);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line1);
        make.bottom.mas_equalTo(self.line1).offset(40);
        make.size.mas_equalTo(self.line1);
    }];
    
    [self.nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.line2.mas_top).offset(-5);
        make.left.equalTo(self.line2.mas_left);
        make.width.mas_equalTo(self.line2);
    }];
    
    [self.nicknameState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickname.mas_right);
        make.centerY.mas_equalTo(self.nickname);
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line2);
        make.top.mas_equalTo(self.line2).offset(40);
        make.size.mas_equalTo(self.line2);
    }];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.line3.mas_top).offset(-5);
        make.centerX.mas_equalTo(self.line3);
        make.size.mas_equalTo(self.nickname);
    }];
    
    [self.passwordState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.password.mas_right);
        make.centerY.mas_equalTo(self.password);
    }];
    
    [self.line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.line3);
        make.top.mas_equalTo(self.line3).offset(40);
        make.size.mas_equalTo(self.line3);
    }];
    
    [self.verification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.line4.mas_top).offset(-5);
        make.centerX.mas_equalTo(self.line4);
        make.size.mas_equalTo(self.password);
    }];
    
    [self.verificationState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.verification.mas_right);
        make.centerY.mas_equalTo(self.verification);
    }];
    
    [self.registerButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line4.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.line4);
        make.width.mas_equalTo(self.verification);
        make.height.mas_equalTo(40);
    }];
    
    [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.registerButon);
        make.top.mas_equalTo(self.registerButon.mas_bottom).offset(10);
    }];
    
    [self.agree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.agreeButton);
        make.left.mas_equalTo(self.agreeButton.mas_right);
    }];
    
    [self.seeAgreement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.registerButon);
        make.centerY.mas_equalTo(self.agreeButton);
    }];
}

- (UITextField *)email{
    if(!_email){
        _email = [UITextField new];
        _email.textAlignment = NSTextAlignmentLeft;
        _email.placeholder = @"请输入邮箱";
        _email.clearsOnBeginEditing = YES;
        _email.font = [UIFont systemFontOfSize:14];
    }
    return _email;
}

- (UILabel *)emailState{
    if (!_emailState) {
        _emailState = [[UILabel alloc]init];
        _emailState.font = [UIFont systemFontOfSize:10];
        _emailState.text = @"不正确";
    }
    return _emailState;
}

- (UIView *)line1{
    if(!_line1){
        _line1 = [UIView new];
        _line1.backgroundColor = [UIColor lightGrayColor];
    }
    return _line1;
}

- (UITextField *)nickname{
    if (!_nickname) {
        _nickname = [UITextField new];
        _nickname.textAlignment = NSTextAlignmentLeft;
        _nickname.placeholder = @"请输入昵称";
        _nickname.clearsOnBeginEditing = YES;
        _nickname.font = [UIFont systemFontOfSize:14];
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

- (UIView *)line2{
    if (!_line2) {
        _line2 = [UIView new];
        _line2.backgroundColor = [UIColor lightGrayColor];
    }
    return _line2;
}

- (UITextField *)password{
    if (!_password) {
        _password = [UITextField new];
        _password.textAlignment = NSTextAlignmentLeft;
        _password.placeholder = @"请输入密码";
        _password.clearsOnBeginEditing = YES;
        _password.font = [UIFont systemFontOfSize:14];
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

- (UIView *)line3{
    if (!_line3) {
        _line3 = [UIView new];
        _line3.backgroundColor = [UIColor lightGrayColor];
    }
    return _line3;
}

- (UITextField *)verification{
    if (!_verification) {
        _verification = [UITextField new];
        _verification.textAlignment = NSTextAlignmentLeft;
        _verification.placeholder = @"验证密码";
        _verification.clearsOnBeginEditing = YES;
        _verification.font = [UIFont systemFontOfSize:14];
        _verification.secureTextEntry = YES;
    }
    return _verification;
}

- (UILabel *)verificationState{
    if (!_verificationState) {
        _verificationState = [[UILabel alloc]init];
        _verificationState.font = [UIFont systemFontOfSize:10];
        _verificationState.text = @"不正确";
    }
    return _verificationState;
}

- (UIView *)line4{
    if (!_line4) {
        _line4 = [UIView new];
        _line4.backgroundColor = [UIColor lightGrayColor];
    }
    return _line4;
}

- (UIButton *)registerButon{
    if (!_registerButon) {
        _registerButon = [UIButton new];
        _registerButon.backgroundColor = [UIColor grayColor];
        [_registerButon setTitle:@"注  册" forState:UIControlStateNormal];
        [_registerButon setTitle:@"格式错误" forState:UIControlStateDisabled];
        [_registerButon setBackgroundImage:[UIImage imageNamed:@"bgButton"] forState:UIControlStateNormal];
    }
    return _registerButon;
}

- (DLRadioButton *)agreeButton{
    if (!_agreeButton) {
        _agreeButton = [[DLRadioButton alloc]init];
        UIColor *color = [UIColor colorWithRed:91.0f/255.0f green:91.0f/255.0f blue:191.0f/255.0f alpha:1.0f];
        _agreeButton.circleColor = color;
        _agreeButton.circleStrokeWidth = 2;
        _agreeButton.circleRadius = 6;
        _agreeButton.indicatorColor = color;
        _agreeButton.indicatorRadius = 2;
    }
    return _agreeButton;
}

- (UILabel *)agree{
    if (!_agree) {
        _agree = [[UILabel alloc]init];
        _agree.text = @"已阅读并同意";
        _agree.font = [UIFont systemFontOfSize:12];
    }
    return _agree;
}

- (UIButton *)seeAgreement{
    if (!_seeAgreement) {
        _seeAgreement = [[UIButton alloc]init];
        [_seeAgreement setTitle:@"《查看协议》" forState:UIControlStateNormal];
        UIColor *color = [UIColor colorWithRed:91.0f/255.0f green:91.0f/255.0f blue:191.0f/255.0f alpha:1.0f];
        [_seeAgreement setTitleColor:color forState:UIControlStateNormal];
        _seeAgreement.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _seeAgreement;
}


@end
