//
//  RecipeDetailCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/21.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "Recipe+CoreDataProperties.h"
#import "RecipeDetailCVC.h"
#import "RecipeDetailModel.h"
#import "RecipeDetailHeaderCell.h"
#import "RecipeRaw+CoreDataProperties.h"
#import "RecipeDetail+CoreDataProperties.h"
#import "RecipeDetailCell.h"
#import "BossDetailSectionHeaderCell.h"
@interface RecipeDetailCVC ()

@property (strong,nonatomic) RecipeDetailModel *viewModel;
@property (strong,nonatomic) RecipeDetailHeaderCell *headerCell;
@property (strong,nonatomic) Recipe *recipe;
@end

@implementation RecipeDetailCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout recipe:(Recipe *)theRecipe{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.recipe = theRecipe;
        self.viewModel  = [[RecipeDetailModel alloc]initWithRecipe:theRecipe.recipe_id andName:theRecipe.chName];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"食谱详解";
    self.leftItem = [self leftItem];
    [self bindWithReactive];
    [self.viewModel downloadData];
    [self.collectionView registerClass:[RecipeDetailHeaderCell class] forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                   withReuseIdentifier:@"header"];
        [self.collectionView registerClass:[BossDetailSectionHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader"];
    [self.collectionView registerClass:[RecipeDetailCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self reloadLayout];
}

- (void)bindWithReactive{
    @weakify(self);
    [RACObserve(self.viewModel,recipeRaw)  subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x.count>0) {
            [self.viewModel saveRecipeRawToCoreData];
        }
    }];
    
    [RACObserve(self.viewModel,allData)  subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x.count>0) {
            [self.viewModel saveDataToCoreData];
        }
    }];
    
    [RACObserve(self.viewModel, reload) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if (x.intValue==1) {
            [self.collectionView reloadData];
        }
    }];
}

- (void)reloadLayout {
    CSStickyHeaderFlowLayout *layout = (id)self.collectionViewLayout;
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width-20, 40.0f);
        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width,160);
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, 160);
        layout.parallaxHeaderAlwaysOnTop = NO;
        layout.disableStickyHeaders = YES;
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel getCount];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.view.frame.size.width-20;
    return CGSizeMake(width, width/4+20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecipeDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    RecipeDetail *detail = [self.viewModel getDetail:indexPath.row];
    
    cell.raw1.label.text = detail.raw1;
    cell.raw2.label.text = detail.raw2;
    cell.raw3.label.text = detail.raw3;
    cell.raw4.label.text = detail.raw4;
    [self setImage:cell.raw1.image urlStr:detail.raw1UrlStr];
    [self setImage:cell.raw2.image urlStr:detail.raw2UrlStr];
    [self setImage:cell.raw3.image urlStr:detail.raw3UrlStr];
    [self setImage:cell.raw4.image urlStr:detail.raw4UrlStr];
    return cell;
}


- (void )setImage:(UIImageView *)view urlStr:(NSString *)urlStr{
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    if (image) {
        view.image = image;
    }else{
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType SDImageCacheTypeDisk, BOOL finished, NSURL *imageURL) {
            view.image = image;
        }];
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:CSStickyHeaderParallaxHeader]){
        _headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header"
                                                                forIndexPath:indexPath];
        _headerCell.backgroundColor = FlatWhite;
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_recipe.urlStr];
        if (image) {
            _headerCell.image.image = image;
        }else{
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:_recipe.urlStr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            } completed:^(UIImage *image, NSError *error, SDImageCacheType SDImageCacheTypeDisk, BOOL finished, NSURL *imageURL) {
                _headerCell.image.image = image;
            }];
        }
        _headerCell.chName.text = _recipe.chName;
        if (_recipe.life.floatValue>0) {
            _headerCell.life.label.text = [NSString stringWithFormat:@" +%@",_recipe.life];
        }else{
            _headerCell.life.label.text = [NSString stringWithFormat:@" %@",_recipe.life];
        }
        if (_recipe.hunger.floatValue>0) {
            _headerCell.hunger.label.text = [NSString stringWithFormat:@" +%@",_recipe.hunger];
        }else{
            _headerCell.hunger.label.text = [NSString stringWithFormat:@" %@",_recipe.hunger];
        }
        if (_recipe.sanity.floatValue>0) {
            _headerCell.sanity.label.text = [NSString stringWithFormat:@" +%@",_recipe.sanity];
        }else{
            _headerCell.sanity.label.text = [NSString stringWithFormat:@" %@",_recipe.sanity];
        }
        if (_recipe.badCycle.floatValue != 0) {
            _headerCell.badCycle.label.text = [NSString stringWithFormat:@"%@天",_recipe.badCycle];
        }else{
            _headerCell.badCycle.label.text = [NSString stringWithFormat:@"不腐烂"];
        }
        _headerCell.cookTime.label.text = [NSString stringWithFormat:@"%@秒",_recipe.cookTime];
        _headerCell.priority.text = [NSString stringWithFormat:@"优先权: %@",_recipe.priority];
        
        NSUInteger needNotNum = [self.viewModel getNeedNotRawNum];
        [self.headerCell initNeedNotRawLabel:needNotNum];
        for (NSUInteger index=0; index<needNotNum; index++) {
            ImageLabel *temp = self.headerCell.needNotRawArray[index];
            RecipeRaw *raw = [self.viewModel getRecipeRaw:1 andRow:index];
            temp.label.text = [NSString stringWithFormat:@"<=%@",raw.needNum];
            UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:raw.urlStr];
            if (image) {
                temp.image.image = image;
            }else{
                [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:raw.urlStr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                } completed:^(UIImage *image, NSError *error, SDImageCacheType SDImageCacheTypeDisk, BOOL finished, NSURL *imageURL) {
                    temp.image.image = image;
                }];
            }
        }
        
        NSUInteger needNum = [self.viewModel getNeedRawNum];
        [self.headerCell initNeedRawLabel:needNum];
        for (NSUInteger index=0; index<needNum; index++) {
            ImageLabel *temp = self.headerCell.needRawArray[index];
            RecipeRaw *raw = [self.viewModel getRecipeRaw:0 andRow:index];
            temp.label.text = [NSString stringWithFormat:@">=%@",raw.needNum];
            UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:raw.urlStr];
            if (image) {
                temp.image.image = image;
            }else{
                [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:raw.urlStr] options:1 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                } completed:^(UIImage *image, NSError *error, SDImageCacheType SDImageCacheTypeDisk, BOOL finished, NSURL *imageURL) {
                    temp.image.image = image;
                }];
            }
        }
        return _headerCell;
    }
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BossDetailSectionHeaderCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SectionHeader"
                                                                                      forIndexPath:indexPath];
        cell.backgroundColor = FlatWhite;
        cell.title.text = @"配方示例";
        return cell;
    }
    return nil;
 
}


@end
