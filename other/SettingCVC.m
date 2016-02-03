//
//  SettingCVC.m
//  饥荒大事件
//
//  Created by 李建国 on 16/1/27.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "SettingCVC.h"
#import "SettingModel.h"
#import "SettingCell.h"
#import "SettingHeaderCell.h"
#import "LoginViewVC.h"
#import "AgreementVC.h"
@interface SettingCVC()<MBProgressHUDDelegate>

@property(strong,nonatomic) SettingHeaderCell *headerCell;
@property(strong,nonatomic) NSArray *titles;
@property (strong,nonatomic) MBProgressHUD *HUD;
@property (strong,nonatomic) UITapGestureRecognizer *tapHUD;
@property (strong,nonatomic) UIImagePickerController *pick;
@property (strong,nonatomic) UITapGestureRecognizer *tapGuesture;
@property (strong,nonatomic) UIImage *image;

@end

@implementation SettingCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[SettingModel alloc]init];
        self.titles = @[@"清空缓存",@"用户协议",@"登录"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户信息";
    [self reloadLayout];
    [self bindWithReactive];
        [self.collectionView registerClass:[SettingHeaderCell class] forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[SettingCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)reloadLayout {
    CSStickyHeaderFlowLayout *layout = (id)self.collectionViewLayout;
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 130);
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, 130);
        layout.parallaxHeaderAlwaysOnTop = NO;
        layout.disableStickyHeaders = YES;
    }
}

- (void )bindWithReactive{
    @weakify(self);
    [RACObserve(self.viewModel.theUser, state) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x) {
            [self.collectionView reloadData];
        }
    }];
    
    [RACObserve(self.viewModel.theUser, portaitState) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x) {
            [self.collectionView reloadData];
        }
    }];
    
    [RACObserve(self.viewModel, data) subscribeNext:^(NSDictionary *x) {
        @strongify(self);
        if (x) {
            NSUInteger state = [[x objectForKey:@"state"] integerValue];
            if (state == 1) {
                [(SettingModel *)self.viewModel updatePortaitUrlStr];
            }else{
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:2];
                [dic setObject:@0 forKey:@"state"];
                [dic setObject:@"上传失败" forKey:@"describe"];
                self.HUD.labelText = @"上传失败";
                self.HUD.progress = 1.0;
            }
        }
    }];
    
    [RACObserve(self.viewModel, data1) subscribeNext:^(NSDictionary *x) {
        @strongify(self);
        if (x) {
            NSNumber *state = [x objectForKey:@"state"];
            if (state.intValue == SUC) {
                self.HUD.labelText = @"上传成功";
                [(SettingModel *)self.viewModel savePortaitUrl];
            }else{
                self.HUD.labelText = @"上传失败";
            }
            self.HUD.progress = 1.0f;
        }
    }];
    
    [RACObserve(self.viewModel.theUser, portaitState) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x) {
            [self.collectionView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width-20, 60);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SettingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row!=0||indexPath.row!=3) {
        cell.line2.hidden = YES;
    }
    cell.describe.text = self.titles[indexPath.row];
    cell.describe.textColor = FlatGreenDark;
    if (indexPath.row == 2) {
        NSString *name = [self.viewModel.theUser getName];
        if (name) {
            cell.describe.text = @"退出登录";
            cell.describe.textColor = FlatRedDark;
        }else{
            cell.describe.text = @"登      录";
            cell.describe.textColor = FlatGreenDark;
        }
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:CSStickyHeaderParallaxHeader]){
        _headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header"
                                                                    forIndexPath:indexPath];
        _headerCell.backgroundColor = FlatWhite;
        _headerCell.name.text = [self.viewModel getName];
        _headerCell.headerImageView.userInteractionEnabled = YES;
        [_headerCell.headerImageView addGestureRecognizer:[self tapGuesture]];
        NSString *url = [self.viewModel.theUser getPortait];
        [self setImageView:_headerCell.headerImageView urlStr:url];
        return _headerCell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            [self.viewModel.manager deleteCache];
            break;
        }
        case 1:{
            AgreementVC *agreement = [[AgreementVC alloc]init];
            [self.navigationController pushViewController:agreement animated:YES];
            break;
        }
        case 2:{
            NSString *name = [self.viewModel.theUser getName];
            if (name) {
                [self loginOut];
            }else{
                LoginViewVC *login = [[LoginViewVC alloc]init];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController pushViewController:login animated:YES];
                });
            }
            break;
        }
    }
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)collectionView:(UICollectionView *)colView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [cell setBackgroundColor:[UIColor whiteColor]];
    });
}

- (UIImagePickerController *)pick{
    if (!_pick) {
        _pick = [[UIImagePickerController alloc]init];
        UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        _pick.sourceType = sourcheType;
        _pick.delegate = self;
        _pick.allowsEditing = YES;
    }
    return _pick;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary*)info{
    _image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGSize size = CGSizeMake(80, 80);
    _image = [self reSizeImage:_image toSize:size];
    [(SettingModel *)self.viewModel savePortait:_image];
    [self.view addSubview:[self HUD]];
    [self.pick dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.pick dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

- (UITapGestureRecognizer *)tapGuesture{
    if (!_tapGuesture) {
        _tapGuesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setPortait:)];
        [_tapGuesture setNumberOfTapsRequired:1];
        [_tapGuesture setNumberOfTouchesRequired:1];
    }
    return _tapGuesture;
}

- (void)setPortait:(UITapGestureRecognizer *)sender{
    NSString *name = [self.viewModel.theUser getName];
    if (name) {
        [self presentViewController:[self pick] animated:YES completion:nil];
    }
}

- (MBProgressHUD *)HUD{
    if (!_HUD) {
        _HUD = [[MBProgressHUD alloc] initWithFrame:self.view.frame];
        _HUD.delegate = self;
        _HUD.labelText = @"头像上传中.....";
        _HUD.progress = 0.0f;
        [_HUD showWhileExecuting:@selector(addImageTask) onTarget:self withObject:nil animated:YES];
    }
    return _HUD;
}

- (void)addImageTask {
    while (_HUD.progress < 1.0f) {
        [NSThread sleepForTimeInterval:0.05];
    }
    [self.HUD show:YES];
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    [self.HUD removeFromSuperview];
    self.HUD = nil;
}

- (void)loginOut{
    UIAlertController * alertCtr = [UIAlertController alertControllerWithTitle:@"确定要退出登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
         [(SettingModel *)self.viewModel loginOut];
    }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    [alertCtr addAction:firstAction];
    [alertCtr addAction:secondAction];
    [self presentViewController:alertCtr animated:YES completion:^{
    }];
}

@end
