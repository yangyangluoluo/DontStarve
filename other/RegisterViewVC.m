//
//  bgViewVC.m
//  Geological
//
//  Created by 李建国 on 15/12/7.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "CSStickyHeaderFlowLayout.h"
#import "Chameleon.h"
#import "ReactiveCocoa.h"
#import "ADTransitionController.h"
#import "RegisterView.h"
#import "RegisterViewVC.h"
#import "RegisterViewModel.h"

#import "LoginViewVC.h"
#import "AgreementVC.h"
#import "DefineState.h"

@interface RegisterViewVC ()

@property (strong,nonatomic) ADTransition *transitionBack;
@property (strong,nonatomic) RegisterView *bgView;
@property (strong,nonatomic) UIBarButtonItem *leftItem;
@property (strong,nonatomic) RACSignal *emailSignal;
@property (strong,nonatomic) RACSignal *nicknameSignal;
@property (strong,nonatomic) RACSignal *passwordSignal;
@property (strong,nonatomic) RACSignal *verificationSignal;
@property (strong,nonatomic) RegisterViewModel *viewModel;

@end

@implementation RegisterViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    self.viewModel = [[RegisterViewModel alloc]init];
    self.bgView = [[RegisterView alloc]initWithFrame:self.view.frame];
    self.navigationItem.leftBarButtonItem = [self leftItem];
    [self bindWithReactive];
    [self.view addSubview:self.bgView];
}
- (void) bindWithReactive{
    [self setEmailSignal];
    [self setNicknameStateSignal];
    [self setPasswordState];
    [self setVerificationState];
    [self registerButtonSignal];
    @weakify(self);
    [RACObserve(self.viewModel, registerState) subscribeNext:^(NSDictionary *x) {
        if (x) {
            @strongify(self);
            [self presentLoginSate:x];
        }
    }];
    
    self.bgView.agreeButton.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        self.bgView.agreeButton.selected =  !self.bgView.agreeButton.selected;
        return [RACSignal empty];
    }];
    
    self.bgView.seeAgreement.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        AgreementVC *agreement = [[AgreementVC alloc]init];
        [self.navigationController pushViewController:agreement animated:YES];
        return [RACSignal empty];
    }];

}

- (void)setEmailSignal{
    _emailSignal = [self.bgView.email.rac_textSignal map:^id(NSString *text) {
        return @([self isValidateEmail:text]);
    }];
    RAC(self.bgView.emailState,textColor) = [_emailSignal map:^id(NSNumber *signal) {
        return [signal boolValue]?FlatGreenDark:FlatRedDark;
    }];
    RAC(self.bgView.emailState,hidden) = [self.bgView.email.rac_textSignal map:^id(NSString *text) {
        return @(text.length>0?0:1);
    }];
    RAC(self.bgView.emailState,text) = [_emailSignal map:^id(NSNumber *nickname) {
        return [nickname boolValue]?@"格式正确":@"格式错误";
    }];
}

-(BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)setNicknameStateSignal{
    _nicknameSignal = [self.bgView.nickname.rac_textSignal map:^id(NSString *text) {
        return @(text.length>2?1:0);
    }];
    RAC(self.bgView.nicknameState,textColor) = [_nicknameSignal map:^id(NSNumber *nickname) {
        return [nickname boolValue]?FlatGreenDark:FlatRedDark;
    }];
    RAC(self.bgView.nicknameState,hidden) = [self.bgView.nickname.rac_textSignal map:^id(NSString *text) {
        return @(text.length>0?0:1);
    }];
    RAC(self.bgView.nicknameState,text) = [_nicknameSignal map:^id(NSNumber *nickname) {
        return [nickname boolValue]?@"格式正确":@"格式错误";
    }];
}

- (void)setPasswordState{
    _passwordSignal = [self.bgView.password.rac_textSignal map:^id(NSString *value) {
        return @(value.length>2?1:0);
    }];
    RAC(self.bgView.passwordState,textColor) = [_passwordSignal map:^id(NSNumber *nickname) {
        return [nickname boolValue]?FlatGreenDark:FlatRedDark;
    }];
    RAC(self.bgView.passwordState,hidden) = [self.bgView.password.rac_textSignal map:^id(NSString *text) {
        return @(text.length>0?0:1);
    }];
    RAC(self.bgView.passwordState,text) = [_passwordSignal map:^id(NSNumber *nickname) {
        return [nickname boolValue]?@"格式正确":@"格式错误";
    }];
}

- (void)setVerificationState{
    _verificationSignal = [RACSignal combineLatest:@[self.bgView.password.rac_textSignal,self.bgView.verification.rac_textSignal]
                                            reduce:^id(NSString *password,NSString *verification){
                                                if (verification.length<2) {
                                                    return @0;
                                                }
                                                else if([verification isEqualToString:password]) {
                                                    return @1;
                                                }else{
                                                    return @2;
                                                }
                                            }];
    RAC(self.bgView.verificationState,textColor) = [_verificationSignal map:^id(NSNumber *verification) {
        if (verification.intValue == 1) {
            return FlatGreenDark;
        }else{
            return FlatRedDark;
        }
    }];
    
    RAC(self.bgView.verificationState,hidden) = [self.bgView.verification.rac_textSignal map:^id(NSString *text) {
        return @(text.length>0?0:1);
    }];
    
    RAC(self.bgView.verificationState,text) = [_verificationSignal map:^id(NSNumber *verification) {
        if (verification.intValue == 0) {
            return @"长度不够";
        }else if(verification.intValue == 1){
            return @"正确";
        }else{
            return @"不一致";
        }
    }];
}

- (void)registerButtonSignal{
    RACSignal *enable= [RACSignal combineLatest:@[_emailSignal,_nicknameSignal,_verificationSignal]
                        reduce:^id(NSNumber *email ,NSNumber *nickname,NSNumber * verification){
                        if (nickname.intValue==1&&verification.intValue==1&&email.intValue==1) {
                          return @1;
                        }else{
                          return @0;
                        }}];
    @weakify(self);
    self.bgView.registerButon.rac_command = [[RACCommand alloc]initWithEnabled:enable signalBlock:^RACSignal *(id input) {
        @strongify(self);
        if (self.bgView.agreeButton.selected==NO) {
            [self sgtUserLogin];
        }else{
            [self.viewModel registerWithName:self.bgView.nickname.text password:self.bgView.password.text email:self.bgView.email.text];
        }
        return [RACSignal empty];
    }];
}

- (void )presentLoginSate:(NSDictionary *)loginState{
    NSUInteger state = [[loginState objectForKey:@"state"] integerValue];
    if (state==REGISTERSUC) {
        NSNumber *rank = @([[loginState objectForKey:@"rank"] integerValue]);
        NSString *name = [loginState objectForKey:@"name"];
        [self.viewModel saveName:name rank:rank];
        NSUInteger count = self.navigationController.viewControllers.count-3;
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count]animated:YES];
    }else{
        NSString *describe = [loginState objectForKey:@"descirbe"];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:describe];
        [hogan addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:20.0]
                      range:NSMakeRange(0, describe.length)];
        [hogan addAttribute:NSForegroundColorAttributeName
                      value:[UIColor redColor]
                      range:NSMakeRange(0, describe.length)];
        [alertController setValue:hogan forKey:@"attributedTitle"];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (UIBarButtonItem *)leftItem{
    if (!_leftItem) {
        _leftItem = [[UIBarButtonItem alloc]init];
        UIImage *bgImage = [UIImage imageNamed:@"back"];
        [_leftItem setImage:bgImage];
        @weakify(self);
        _leftItem.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            NSUInteger count = self.navigationController.viewControllers.count-2;
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count]animated:YES];
            return [RACSignal empty];
        }];
    }
    return _leftItem;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.bgView.password resignFirstResponder];
    [self.bgView.nickname resignFirstResponder];
    [self.bgView.verification resignFirstResponder];
}

- (void )sgtUserLogin{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你未同意服务条款" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:^{}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)dealloc{
    NSLog(@"RegisterViewVC dealloc");
}
@end
