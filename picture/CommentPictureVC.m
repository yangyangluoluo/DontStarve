//
//  CommentPictureVC.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/30.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Picture+CoreDataProperties.h"
#import "CommentPictureVC.h"
#import "MBProgressHUD.h"
#import "ReactiveCocoa.h"
#import "Chameleon.h"
#import "CommentPictureVC.h"
#import "CommentPictureModel.h"
#import "ReplyQuestionView.h"
#import "DefineState.h"
@interface CommentPictureVC ()<MBProgressHUDDelegate>

@property (strong,nonatomic) CommentPictureModel *viewModel;
@property (strong,nonatomic) ReplyQuestionView *bgView;
@property (strong,nonatomic) UIBarButtonItem *leftItem;
@property (strong,nonatomic) UIBarButtonItem *rightItem;
@property (strong,nonatomic) MBProgressHUD *HUD;
@property (assign,nonatomic) BOOL keyboardIsVisible;

@end

@implementation CommentPictureVC

- (instancetype)initWithPicture:(Picture *)picture{
    self = [super init];
    if (self) {
        self.viewModel = [[CommentPictureModel alloc]initWithPicture:picture];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"评论图片";
    [self.view addSubview:[self bgView]];
    self.navigationItem.rightBarButtonItem = [self rightItem];
    [self setBgViewContent];
    [self observeKeyboardState];
    [self bindWithReactive];
    
}

- (void) bindWithReactive{
    @weakify(self);
    RACSignal *enable = [self.bgView.comments.rac_textSignal  map:^id(NSString *value) {
        return @(((value.length>=2)&&(value.length<=500))?1:0);
    }];
    self.rightItem.rac_command = [[RACCommand alloc]initWithEnabled:enable signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.view addSubview:[self HUD]];
        [self.viewModel savePictureComment:self.bgView.comments.text];
        return [RACSignal empty];
    }];
    
    [self.bgView.comments.rac_textSignal  subscribeNext:^(NSString *x) {
        @strongify(self);
        self.bgView.countWords.text = [NSString stringWithFormat:@"已经输入: %lu个字",(unsigned long)x.length];
    }];
    
    [RACObserve(self.viewModel.theUser, state) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x) {
            NSString *name=[self.viewModel.theUser getName];
            if (!name) {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]animated:YES];
            }
        }
    }];
    
    [RACObserve(self.viewModel, data) subscribeNext:^(NSDictionary *x) {
        @strongify(self);
        if (x) {
            NSUInteger state = [[x objectForKey:@"state"] intValue];
            [NSThread sleepForTimeInterval:0.5];
            self.HUD.labelText = [x objectForKey:@"descirbe"];
            self.HUD.progress = 1.0f;
            self.state = @(state==SUC?SUC:FAIL);
        }
    }];
}

- (ReplyQuestionView *)bgView{
    if (!_bgView) {
        CGRect rectNav = self.navigationController.navigationBar.frame;
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        CGFloat height = rectNav.size.height + rectStatus.size.height;
        CGRect frame = CGRectMake(0, height, self.view.frame.size.width, self.view.frame.size.height - height);
        _bgView = [[ReplyQuestionView alloc]initWithFrame:frame];
    }
    return _bgView;
}

- (void)setBgViewContent{
    self.bgView.countWords.textColor = self.bgView.comments.backgroundColor;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.bgView.comments resignFirstResponder];
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
        UIImage *image = [UIImage imageNamed:@"upload"];
        [self.rightItem setImage:image];
    }
    return _rightItem;
}

- (void)observeKeyboardState{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center  addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];
    [center  addObserver:self selector:@selector(keyboardDidHide)  name:UIKeyboardWillHideNotification object:nil];
    _keyboardIsVisible = NO;
}

- (void)keyboardDidShow{
    _keyboardIsVisible = YES;
}

- (void)keyboardDidHide{
    _keyboardIsVisible = NO;
}

- (BOOL)keyboardIsVisible{
    return _keyboardIsVisible;
}

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
        [NSThread sleepForTimeInterval:0.05];
    }
    [NSThread sleepForTimeInterval:0.5];
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    [self.HUD removeFromSuperview];
    self.HUD = nil;
    [self commentQuestionState];
}

- (void)commentQuestionState{
    NSString *describe = [[self.viewModel data] objectForKey:@"descirbe"];
    UIAlertController * alertCtr = [UIAlertController alertControllerWithTitle:describe message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"继续评论" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
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
    NSLog(@"WriteSchoolCommentVC");
}

@end
