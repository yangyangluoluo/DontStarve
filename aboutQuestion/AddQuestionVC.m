//
//  AddQuestionVC.m
//  Geological1
//
//  Created by 李建国 on 15/12/27.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "MBProgressHUD.h"
#import "ReactiveCocoa.h"
#import "Chameleon.h"
#import "AddQuestionVC.h"
#import "AddQuestionView.h"
#import "AddQuestionModel.h"
#import "DefineState.h"

@interface AddQuestionVC ()<MBProgressHUDDelegate>

@property (strong,nonatomic) AddQuestionModel *viewModel;
@property (strong,nonatomic) UIBarButtonItem *leftItem;
@property (strong,nonatomic) UIBarButtonItem *rightItem;
@property (strong,nonatomic) AddQuestionView *bgView;
@property (strong,nonatomic) MBProgressHUD *HUD;

@end

@implementation AddQuestionVC

- (instancetype)init{
    self = [super init];
    if (self) {
        self.viewModel = [[AddQuestionModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor flatWhiteColor];
    self.title = @"提出问题";
    self.navigationItem.leftBarButtonItem = [self leftItem];
    self.navigationItem.rightBarButtonItem = [self rightItem];
    [self.view addSubview:[self bgView]];
    [self bindWithReactive];
    
}

- (void) bindWithReactive{
   @weakify(self);
    RAC(self.bgView.title,userInteractionEnabled) = [self.bgView.title.rac_textSignal map:^id(NSString *value) {
        return @(value.length<=20?1:0);
    }];
    
    RAC(self.bgView.describe,userInteractionEnabled) = [self.bgView.describe.rac_textSignal map:^id(NSString *value) {
        return @(value.length<=500?1:0);
    }];
    
    RACSignal *enable = [RACSignal combineLatest:@[self.bgView.describe.rac_textSignal,self.bgView.title.rac_textSignal]
                                          reduce:^id(NSString *describe,NSString *title){
                                              return @((describe.length>=3&&title.length>=3)?YES:NO);
                                          }];
    
 
    self.rightItem.rac_command = [[RACCommand alloc]initWithEnabled:enable signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.view addSubview:[self HUD]];
        [self.viewModel saveQuetion:self.bgView.describe.text title:self.bgView.title.text];
        return [RACSignal empty];
    }];

    [RACObserve(self.viewModel, addQuestionState)  subscribeNext:^(NSDictionary *x) {
        @strongify(self);
        if (x) {
            NSUInteger state = [[x objectForKey:@"state"] intValue];
            [NSThread sleepForTimeInterval:0.5];
            if (state == SUC) {
                self.HUD.progress = 1.0f;
                self.HUD.labelText = @"对接成功...";
            }else{
                self.HUD.progress = 1.0f;
                self.HUD.labelText = @"对接失败...";
            }
        }
    }];
    
    [RACObserve(self.viewModel, state) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x) {
            NSString *name=[self.viewModel.theUser getName];
            if (!name) {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0]animated:YES];
            }
        }
    }];
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

- (UIBarButtonItem *)rightItem{
    if (!_rightItem) {
        self.rightItem = [[UIBarButtonItem alloc]init];
        UIImage *image = [UIImage imageNamed:@"save"];
        [self.rightItem setImage:image];
    }
    return _rightItem;
}


- (AddQuestionView *)bgView{
    if (!_bgView) {
        CGRect rectNav = self.navigationController.navigationBar.frame;
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        CGFloat height = rectNav.size.height + rectStatus.size.height;
        CGRect frame = CGRectMake(0, height, self.view.frame.size.width, self.view.frame.size.height - height);
        _bgView = [[AddQuestionView alloc]initWithFrame:frame];
    }
    return _bgView;
}

#pragma mark HUD

- (MBProgressHUD *)HUD{
    if (!_HUD) {
        _HUD = [[MBProgressHUD alloc] initWithFrame:self.view.frame];
        _HUD.delegate = self;
        _HUD.labelText = @"服务器对接中...";
        [_HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
    }
    return _HUD;
}

- (void)myProgressTask {
    while (_HUD.progress < 1.0f) {
    }
    [NSThread sleepForTimeInterval:0.5];
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    [self.HUD removeFromSuperview];
    self.HUD = nil;
    [self addQuestionState];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.bgView.describe resignFirstResponder];
    [self.bgView.title resignFirstResponder];
}

- (void)addQuestionState{
    NSString *describe = [[self.viewModel addQuestionState] objectForKey:@"descirbe"];
    UIAlertController * alertCtr = [UIAlertController alertControllerWithTitle:describe message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"继续添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"返回前页面" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSUInteger count = self.navigationController.viewControllers.count-2;
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:count]animated:YES];
    }];
    [alertCtr addAction:firstAction];
    [alertCtr addAction:secondAction];
    [self presentViewController:alertCtr animated:YES completion:^{
    }];
}

- (void)dealloc{
    NSLog(@"AddQuestionVC dealloc");
}

@end
