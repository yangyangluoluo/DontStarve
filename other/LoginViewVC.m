//
//  LoginViewVC.m
//  Geological
//
//  Created by 李建国 on 15/12/6.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "ReactiveCocoa.h"
#import "LoginViewVC.h"
#import "LoginView.h"
#import "LoginViewModel.h"
#import "RegisterViewVC.h"
#import "DefineState.h"
@interface LoginViewVC ()

@property (strong,nonatomic) LoginView *bgView;

@end

@implementation LoginViewVC

- (instancetype)init{
    self = [super init];
    if (self) {
        _viewModel =[[LoginViewModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录";
    self.bgView = [[LoginView alloc]initWithFrame:self.view.frame];
    [self bindWithReactive];
    [self.view addSubview:[self bgView]];
}

- (void) bindWithReactive{
    [self setNicknameStateSignal];
    [self setPasswordState];
    [self loginButtonSignal];
    [self setUserRegisterSignal];
    @weakify(self);
    [[RACObserve(self.viewModel, data)deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSDictionary *x) {
        @strongify(self);
        if (x) {
            [self presentLoginSate:x];
        }
    }];
}

- (void )setNicknameStateSignal{
    RACSignal *nicknameSignal = [self.bgView.nickname.rac_textSignal map:^id(NSString *text) {
        return @(text.length>2?1:0);
    }];
    RAC(self.bgView.nicknameState,textColor) = [nicknameSignal map:^id(NSNumber *nickname) {
        return [nickname boolValue]?FlatGreenDark:FlatRedDark;
    }];
    RAC(self.bgView.nicknameState,hidden) = [self.bgView.nickname.rac_textSignal map:^id(NSString *text) {
        return @(text.length>0?0:1);
    }];
    RAC(self.bgView.nicknameState,text) = [nicknameSignal map:^id(NSNumber *nickname) {
        return [nickname boolValue]?@"格式正确":@"格式错误";
    }];
}

- (void )setPasswordState{
    RACSignal *passwordSignal = [self.bgView.password.rac_textSignal map:^id(NSString *text) {
        return @(text.length>2?1:0);
    }];
    RAC(self.bgView.passwordState,textColor) = [passwordSignal map:^id(NSNumber *nickname) {
        return [nickname boolValue]?FlatGreenDark:FlatRedDark;
    }];
    RAC(self.bgView.passwordState,hidden) = [self.bgView.password.rac_textSignal map:^id(NSString *text) {
        return @(text.length>0?0:1);
    }];
    RAC(self.bgView.passwordState,text) = [passwordSignal map:^id(NSNumber *nickname) {
        return [nickname boolValue]?@"格式正确":@"格式错误";
    }];
}

- (void)loginButtonSignal{
    @weakify(self);
    RACSignal *valid= [RACSignal combineLatest:@[self.bgView.nickname.rac_textSignal,self.bgView.password.rac_textSignal] reduce:^id(NSString *nickname,NSString *password){
        return @(nickname.length>2 && password.length>2);
    }];
    self.bgView.loginButton.rac_command = [[RACCommand alloc]initWithEnabled:valid signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.viewModel loginWithName:self.bgView.nickname.text password:self.bgView.password.text];
        return [RACSignal empty];
    }];
}

- (void)setUserRegisterSignal{
    @weakify(self);
    self.bgView.userRegister.rac_command = [[RACCommand alloc]  initWithEnabled:nil signalBlock:^RACSignal *(id input) {
        @strongify(self);
        RegisterViewVC *registerVC = [[RegisterViewVC alloc]init];
        [self.navigationController pushViewController:registerVC animated:YES];
        return [RACSignal empty];
    }];
}

- (void )presentLoginSate:(NSDictionary *)loginState{
    NSUInteger state = [[loginState objectForKey:@"state"] intValue];
    if (state==LOGINSUC) {
        [self.viewModel.theUser savePortait:[NSString stringWithFormat:@"%@%@",PREFIX,[loginState objectForKey:@"urlStr"]]];
        [self.viewModel.theUser saveName:[loginState objectForKey:@"name"]];
        [self.viewModel.theUser changState];
        NSUInteger count = self.navigationController.viewControllers.count-2;
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.bgView.nickname resignFirstResponder];
    [self.bgView.password resignFirstResponder];
}

- (void)dealloc{
    NSLog(@"LoginViewVC dealloc");
}
@end
