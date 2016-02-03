//
//  RecipeCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/17.
//  Copyright © 2016年 李建国. All rights reserved.
//

#import "RecipeCVC.h"
#import "RecipeCell.h"
#import "Recipe+CoreDataProperties.h"
#import "RecipeModel.h"
#import "RecipeDetailCVC.h"
@interface RecipeCVC ()

@end

@implementation RecipeCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[RecipeModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"食谱列表";
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];
    [self.viewModel downloadData];
    [self bindWithReactive];
    [self.collectionView registerClass:[RecipeCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel getCount];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width-20, 80);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecipeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    Recipe *recipe = [self.viewModel getObject:indexPath.row];
    [self setImageView:cell.image urlStr:recipe.urlStr];
    cell.chName.text = recipe.chName;
    if (recipe.life.floatValue>0) {
        cell.life.label.text = [NSString stringWithFormat:@" +%@",recipe.life];
    }else{
        cell.life.label.text = [NSString stringWithFormat:@" %@",recipe.life];
    }
    if (recipe.hunger.floatValue>0) {
        cell.hunger.label.text = [NSString stringWithFormat:@" +%@",recipe.hunger];
    }else{
        cell.hunger.label.text = [NSString stringWithFormat:@" %@",recipe.hunger];
    }
    if (recipe.sanity.floatValue>0) {
        cell.sanity.label.text = [NSString stringWithFormat:@" +%@",recipe.sanity];
    }else{
        cell.sanity.label.text = [NSString stringWithFormat:@" %@",recipe.sanity];
    }
    if (recipe.badCycle.floatValue != 0) {
        cell.badCycle.label.text = [NSString stringWithFormat:@"%@天",recipe.badCycle];
    }else{
        cell.badCycle.label.text = [NSString stringWithFormat:@"不腐烂"];
    }
    cell.cookTime.label.text = [NSString stringWithFormat:@"%@秒",recipe.cookTime];
    cell.priority.text = [NSString stringWithFormat:@"优先权: %@",recipe.priority];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Recipe *recipe = [self.viewModel getObject:indexPath.row];
    CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
    RecipeDetailCVC *recipeDetail = [[RecipeDetailCVC alloc]initWithCollectionViewLayout:layout recipe:recipe];
    [self.navigationController pushViewController:recipeDetail animated:YES];
}

@end
