//
//  AddPictureVC.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/29.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "MBProgressHUD.h"
#import "ReactiveCocoa.h"
#import "Chameleon.h"
#import "Masonry.h"
#import "CircleView.h"
#import "AddPictureVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "AddPictureModel.h"
#import "AddPictureView.h"
#import "DefineState.h"
@interface AddPictureVC ()<MBProgressHUDDelegate>

@property (strong,nonatomic) CircleView *circle;
@property (strong,nonatomic) ELCImagePickerController *elcPicker;
@property (strong,nonatomic) UILabel *imageCount;
@property (strong,nonatomic) UILabel * notice;
@property (strong,nonatomic) UIBarButtonItem *leftItem;
@property (strong,nonatomic) UIBarButtonItem *rightItem;
@property (strong,nonatomic) AddPictureModel *viewModel;
@property (strong,nonatomic) MBProgressHUD *HUD;
@property (strong,nonatomic) AddPictureView *bgView;
@property (strong,nonatomic) NSNumber *stage;
@property (strong,nonatomic) NSNumber *uploading;

@end

@implementation AddPictureVC

- (instancetype )init{
    self = [super init];
    if (self) {
        self.viewModel  = [[AddPictureModel alloc]init];
        self.stage = @1;
        self.uploading = @0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传饥荒图片   ";    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [self getLeftItem];
    self.navigationItem.rightBarButtonItem = [self getRightItem];
    [self.view addSubview:[self circle]];
    [self.view addSubview:[self scrollView]];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).offset(-30);
        make.height.mas_equalTo(200);
    }];
    
    [self.view addSubview:[self notice]];
    [self.notice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.scrollView.mas_top).offset(-2);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.view addSubview:[self imageCount]];
    [self.imageCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.notice.mas_top).offset(-5);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.view addSubview:[self bgView]];
    self.bgView.hidden = YES;
    [self bindWithReactive];
}

- (void) bindWithReactive{
    @weakify(self);
    [self.bgView.describe.rac_textSignal  subscribeNext:^(NSString *x) {
        @strongify(self);
        self.bgView.countWords.text = [NSString stringWithFormat:@"已经输入: %lu个字",(unsigned long)x.length];
    }];
    
    
    RACSignal *enable1 = [self.bgView.describe.rac_textSignal  map:^id(NSString *value) {
        return @(((value.length>=2)&&(value.length<=100))?1:0);
    }];
    
    RACSignal *enable2 = [RACObserve(self, chosenImages) map:^id(NSArray *value) {
        return @(value.count==0?0:1);
    }];
    
    RACSignal *enable3 = [RACObserve(self, uploading) map:^id(NSNumber *value) {
        if (self.stage.intValue==2) {
            return@(value.intValue==1?2:3);
        }else{
            return @(value.intValue==1?0:1);
        }
    }];
    
    RACSignal *enable= [RACSignal combineLatest:@[enable1,enable2,enable3]
                                         reduce:^id(NSNumber *en1 ,NSNumber *en2,NSNumber *en3){
                                             if (en2.intValue==1 && en3.intValue==1) {
                                                 return @1;
                                             }else if (en1.intValue==1 && en3.intValue ==3){
                                                 return @1;
                                             }else{
                                                 return @0;
                                             }}];
    
    self.rightItem.rac_command = [[RACCommand alloc]initWithEnabled:enable signalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.view addSubview:[self HUD]];
        self.uploading = @1;
        if (self.stage.intValue==1) {
            [self.viewModel saveImageData:self.chosenImages];
        }else{
            [self.viewModel addPicture:self.bgView.describe.text];
        }
        return [RACSignal empty];
    }];

    [RACObserve(self.viewModel, total)  subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.intValue!=ZERO) {
            self.rightItem.enabled = NO;
            if (x.intValue == self.chosenImages.count) {
                self.HUD.labelText = @"上传完成.....";
                self.HUD.progress = 1.0f;
            }else{
                self.HUD.labelText =  [NSString stringWithFormat:@"完成:%d/%lu成功:%lu张失败:%lu张",
                                       x.intValue,self.chosenImages.count,self.viewModel.sucNum,self.viewModel.failNum];
            }
        }
    }];
    
    [RACObserve(self.viewModel, data1) subscribeNext:^(NSDictionary *x) {
        if (x) {
            @strongify(self);
            self.HUD.labelText = [x objectForKey:@"describe"];
            self.HUD.progress = 1.0f;
        }
    }];
    
    [RACObserve(self.viewModel.theUser, state) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x) {
            NSString *name=[self.viewModel.theUser getName];
            if (!name) {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0]animated:YES];
            }
        }
    }];
}

- (AddPictureView *)bgView{
    if (!_bgView) {
        CGRect rectNav = self.navigationController.navigationBar.frame;
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        CGFloat height = rectNav.size.height + rectStatus.size.height;
        CGRect frame = CGRectMake(0,height, self.view.frame.size.width, self.view.frame.size.height-height);
        _bgView = [[AddPictureView alloc]initWithFrame:frame];
        _bgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
    }
    return _bgView;
}

- (UILabel *)imageCount{
    if (!_imageCount) {
        _imageCount = [[UILabel alloc]init];
        NSString *imageNumStr= [NSString stringWithFormat:@"选择了 0 张图片"];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:imageNumStr];
        [str addAttribute:NSForegroundColorAttributeName value:FlatGreenDark range:NSMakeRange(3,3)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:30.0] range:NSMakeRange(3,3)];
        [str addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(3,3)];
        _imageCount.attributedText = str;
        _imageCount.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    }
    return _imageCount;
}


- (UILabel *)notice{
    if (!_notice) {
        _notice = [[UILabel alloc]init];
        _notice.textColor = [UIColor redColor];
        _notice.text = @"请不要上传与《饥荒》无关的图片,谢谢合作!";
        _notice.font = [UIFont systemFontOfSize:10];
    }
    return _notice;
}

- (CircleView *)circle{
    if (!_circle) {
        CGRect rectNav = self.navigationController.navigationBar.frame;
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        CGFloat height = rectNav.size.height + rectStatus.size.height;
        CGFloat width  = 120;
        CGRect frame = CGRectMake(CGRectGetMidX(self.view.frame)-width/2,self.view.frame.size.height-width-height, width, width);
        _circle = [[CircleView alloc]initWithFrame:frame strokeWidth:10];
        [_circle.addButton setTitle:@"选择照片" forState:UIControlStateNormal];
        _circle.addButton.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            [self elcPicker];
            [self presentViewController:self.elcPicker animated:YES completion:nil];
            return [RACSignal empty];
        }];
    }
    return _circle;
}


- (ELCImagePickerController *)elcPicker{
    if (!_elcPicker) {
        _elcPicker = [[ELCImagePickerController alloc]init];
        _elcPicker.maximumImagesCount = 6;
        _elcPicker.imagePickerDelegate = self;
    }
    return _elcPicker;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.layer.borderColor = FlatGreenDark.CGColor;
        _scrollView.layer.borderWidth = 2;
        _scrollView.alwaysBounceVertical = NO;
    }
    return _scrollView;
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    for (UIView *v in [_scrollView subviews]) {
        [v removeFromSuperview];
    }
    NSString *imageNumStr= [NSString stringWithFormat:@"选择了 %ld 张图片",(unsigned long)[info count]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:imageNumStr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3,3)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:30.0] range:NSMakeRange(3,3)];
    [str addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(3,3)];
    self.imageCount.attributedText = str;

    CGRect workingFrame = _scrollView.frame;
    workingFrame.origin.x = 0;
    workingFrame.origin.y = 0;
    workingFrame.size.width = 100;

    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [images addObject:image];
                
                UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
                imageview.layer.borderWidth = 2;
                imageview.layer.borderColor = FlatGreenDark.CGColor;
                [imageview setContentMode:UIViewContentModeScaleToFill];
                imageview.frame = workingFrame;
                
                [_scrollView addSubview:imageview];
                
                workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width+10;
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                
                [images addObject:image];
                
                UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
                [imageview setContentMode:UIViewContentModeScaleAspectFit];
                imageview.frame = workingFrame;
                
                [_scrollView addSubview:imageview];
                
                workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width+10;
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else {
            NSLog(@"Uknown asset type");
        }
    }
    
    self.chosenImages = images;
    [_scrollView setPagingEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
}

- (UIBarButtonItem *)getLeftItem{
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

- (UIBarButtonItem *)getRightItem{
    if (!_rightItem) {
        self.rightItem = [[UIBarButtonItem alloc]init];
        UIImage *image = [UIImage imageNamed:@"upload"];
        [self.rightItem setImage:image];
    }
    return self.rightItem;
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.bgView.describe resignFirstResponder];
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
        [NSThread sleepForTimeInterval:0.05];
    }
    [NSThread sleepForTimeInterval:1];
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    [self.HUD removeFromSuperview];
    self.HUD = nil;
    if (self.stage.intValue==1) {
        if (self.viewModel.sucNum == self.chosenImages.count) {
            self.bgView.hidden = NO;
            self.stage = @2;
        }else{
            self.stage =@1;
            [self addPictureState];
        }
    }else{
        [self addPictureState];
    }
    self.uploading = @0;
}

- (void)addPictureState{
    NSString *describe = [[self.viewModel data1] objectForKey:@"describe"];
    if (describe==nil) {
        describe = @"上传图片失败";
    }
    UIAlertController * alertCtr = [UIAlertController alertControllerWithTitle:describe message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"继续添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.bgView.hidden = YES;
        self.bgView.describe.text = nil;
        self.stage =@1;
        self.viewModel.data = nil;
        self.viewModel.data1 = nil;
        self.viewModel.sucNum =  0;
        self.viewModel.failNum = 0;
        self.viewModel.total = 0;
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
@end
