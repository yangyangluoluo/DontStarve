//
//  HomeCVC.m
//  Geological1
//
//  Created by 李建国 on 15/12/28.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "Chameleon.h"
#import "ReactiveCocoa.h"
#import "CSStickyHeaderFlowLayout.h"
#import "HomeCVC.h"
#import "HomeSectionCell.h"
#import "HomeCell.h"
#import "HomeModel.h"
#import "UIImageView+WebCache.h"
#import "HomeHeaderCell.h"
#import "CharactersCVC.h"
#import "MyADTransition.h"
#import "AnimalCVC.h"
#import "PlantCVC.h"
#import "ConstructionCVC.h"
@interface HomeCVC ()
@property (strong,nonatomic) HomeHeaderCell *homeHeaderCell;
@property (strong,nonatomic) NSArray *describe;
@property (strong,nonatomic) HomeModel *viewModel;
@end

@implementation HomeCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {

        self.describe = @[@"沙漠风景",@"高原风景",@"北极风景"];
        self.viewModel = [[HomeModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"主页";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[HomeSectionCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader"];
    [self.collectionView registerClass:[HomeHeaderCell class] forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withReuseIdentifier:@"header"];
    [self reloadLayout];
    [self bindWithReactive];
}

- (void) bindWithReactive{
//    @weakify(self);
//    [RACObserve(self.viewModel,allSchool) subscribeNext:^(NSArray *x) {
//        @strongify(self)
//        if (x) {
//            [self.collectionView reloadData];
//        }
//    }];
}

- (void)reloadLayout {
    CSStickyHeaderFlowLayout *layout = (id)self.collectionViewLayout;
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.headerReferenceSize = CGSizeMake(self.collectionView.bounds.size.width, 30.0f);  //设置head大小
        CGFloat height = self.view.frame.size.width*0.4;
        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, height);
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, height);
        layout.parallaxHeaderAlwaysOnTop = NO;
        layout.disableStickyHeaders = YES;
    }
}

- (CGFloat)findHeightForText:(NSString *)text havingMaximumWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size.height;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.viewModel getCount];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel getSectionCount:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.view.frame.size.width/2;
    CGFloat height = width * 0.5;
    return CGSizeMake(width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.title.text = [self.viewModel getTitle:indexPath.section row:indexPath.row];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HomeSectionCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SectionHeader"
                                                                          forIndexPath:indexPath];
        if (indexPath.section==0) {
            cell.title.text = @"饥荒生物";
        }

        return cell;
    }
    if ([kind isEqualToString:CSStickyHeaderParallaxHeader]){
        _homeHeaderCell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header"
                                                                         forIndexPath:indexPath];
        [_homeHeaderCell setImageNum:5];
        _homeHeaderCell.imageScroll.delegate = self;
        _homeHeaderCell.imageScroll.tag = 1;
        return _homeHeaderCell;
        
        }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0 && indexPath.row==0) {
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        CharactersCVC *character = [[CharactersCVC alloc]initWithCollectionViewLayout:layout];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:character];
        navi.transitioningDelegate = [MyADTransition nextTransitionWithFrame:self.view.frame];
        [self presentViewController:navi animated:YES completion:nil];
    }else if (indexPath.section==0 && indexPath.row==1){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        AnimalCVC *animal = [[AnimalCVC alloc]initWithCollectionViewLayout:layout];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:animal];
        navi.transitioningDelegate = [MyADTransition nextTransitionWithFrame:self.view.frame];
        [self presentViewController:navi animated:YES completion:nil];
    }else if (indexPath.section==0 && indexPath.row ==2){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        PlantCVC *plant = [[PlantCVC alloc]initWithCollectionViewLayout:layout];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:plant];
        navi.transitioningDelegate = [MyADTransition nextTransitionWithFrame:self.view.frame];
        [self presentViewController:navi animated:YES completion:nil];
    }else if (indexPath.section==0 && indexPath.row ==3){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        ConstructionCVC *construction = [[ConstructionCVC alloc]initWithCollectionViewLayout:layout];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:construction];
        navi.transitioningDelegate = [MyADTransition nextTransitionWithFrame:self.view.frame];
        [self presentViewController:navi animated:YES completion:nil];
    }

}

#pragma mark scrollView

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (sender.tag ==1) {
        int page = sender.contentOffset.x/self.view.frame.size.width;
        _homeHeaderCell.pageControl.currentPage = page;
        _homeHeaderCell.pageControl.currentPage  = page;
    }
}


@end
