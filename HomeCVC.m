//
//  HomeCVC.m
//  Geological1
//
//  Created by 李建国 on 15/12/28.
//  Copyright © 2015年 李建国. All rights reserved.
//
#import "HomeDescribe.h"
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
#import "BossCVC.h"
#import "RecipeCVC.h"
#import "FoodRawCVC.h"
#import "ToolCVC.h"
#import "FireCVC.h"
#import "ProduceCVC.h"
#import "ScienceCVC.h"
#import "BuildCVC.h"
#import "RefineCVC.h"
#import "MagicCVC.h"
#import "AncientCVC.h"
#import "BookCVC.h"
#import "SurvivalCVC.h"
#import "FightCVC.h"
#import "DressCVC.h"
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
}

- (void)reloadLayout {
    CSStickyHeaderFlowLayout *layout = (id)self.collectionViewLayout;
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.headerReferenceSize = CGSizeMake(self.collectionView.bounds.size.width, 25.0f);  //设置head大小
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
    CGFloat width = self.view.frame.size.width/4;
    CGFloat height = width ;
    return CGSizeMake(width, height+20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    HomeDescribe *describe = [self.viewModel getDescribe:indexPath.section row:indexPath.row];
    cell.chName.text = describe.chName;
    cell.enName.text = describe.enName;
    cell.image.image = [UIImage imageNamed:describe.icon];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HomeSectionCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SectionHeader"
                                                                          forIndexPath:indexPath];
        cell.backgroundColor = FlatGreenDark;
        cell.title.font = [UIFont systemFontOfSize:18];
        if (indexPath.section==0) {
            cell.title.text = @"游戏大全";
        }else if (indexPath.section == 1){
            cell.title.text = @"游戏资料";
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
        [self.navigationController pushViewController:character animated:YES];
    }else if (indexPath.section==0 && indexPath.row==1){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        AnimalCVC *animal = [[AnimalCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:animal animated:YES];
    }else if (indexPath.section==0 && indexPath.row ==2){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        PlantCVC *plant = [[PlantCVC alloc]initWithCollectionViewLayout:layout];
      [self.navigationController pushViewController:plant animated:YES];
    }else if (indexPath.section==0 && indexPath.row ==3){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        ConstructionCVC *construction = [[ConstructionCVC alloc]initWithCollectionViewLayout:layout];
       [self.navigationController pushViewController:construction animated:YES];
    }else if (indexPath.section==0 && indexPath.row == 4){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        BossCVC *boss = [[BossCVC alloc]initWithCollectionViewLayout:layout];
       [self.navigationController pushViewController:boss animated:YES];
    }else if (indexPath.section==0 && indexPath.row == 5){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        RecipeCVC *recipe = [[RecipeCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:recipe animated:YES];
    }else if (indexPath.section==0 && indexPath.row == 6){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        FoodRawCVC *foodRaw = [[FoodRawCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:foodRaw animated:YES];
    }else if (indexPath.section==1 && indexPath.row == 0){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        ToolCVC *cvc = [[ToolCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:cvc animated:YES];
    }else if (indexPath.section==1 && indexPath.row == 1){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        FireCVC *cvc = [[FireCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:cvc animated:YES];
    }else if (indexPath.section==1 && indexPath.row == 2){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        SurvivalCVC *cvc = [[SurvivalCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:cvc animated:YES];
    }else if (indexPath.section==1 && indexPath.row == 3){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        ProduceCVC *cvc = [[ProduceCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:cvc animated:YES];
    }else if (indexPath.section==1 && indexPath.row == 4){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        ScienceCVC *cvc = [[ScienceCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:cvc animated:YES];
    }else if (indexPath.section==1 && indexPath.row == 5){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        FightCVC *cvc = [[FightCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:cvc animated:YES];
    }
    else if (indexPath.section==1 && indexPath.row == 6){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        BuildCVC *cvc = [[BuildCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:cvc animated:YES];
    }else if (indexPath.section==1 && indexPath.row == 7){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        RefineCVC *cvc = [[RefineCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:cvc animated:YES];
    }else if (indexPath.section==1 && indexPath.row == 8){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        MagicCVC *cvc = [[MagicCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:cvc animated:YES];
    }else if (indexPath.section==1 && indexPath.row == 9){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        DressCVC *cvc = [[DressCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:cvc animated:YES];
    }
    else if (indexPath.section==1 && indexPath.row == 10){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        BookCVC *cvc = [[BookCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:cvc animated:YES];
    }else if (indexPath.section==1 && indexPath.row == 11){
        CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
        AncientCVC *cvc = [[AncientCVC alloc]initWithCollectionViewLayout:layout];
        [self.navigationController pushViewController:cvc animated:YES];
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
