//
//  FoodRawCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/15.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "FoodRawCVC.h"
#import "FoodRawModel.h"
#import "FoodRawCell.h"
#import "FoodRaw+CoreDataProperties.h"
@interface FoodRawCVC ()

@end

@implementation FoodRawCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[FoodRawModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"食材列表";
    [self.viewModel downloadData];
    [self bindWithReactive];
    [self.collectionView registerClass:[FoodRawCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    FoodRawCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    FoodRaw *foodRaw = [self.viewModel getObject:indexPath.row];
    [self setImageView:cell.image urlStr:foodRaw.urlStr];
    cell.chName.text = foodRaw.chName;
    cell.edibleMethod.text = foodRaw.edibleMethod;
    if (foodRaw.life.floatValue>0) {
        cell.life.label.text = [NSString stringWithFormat:@" +%@",foodRaw.life];
    }else{
        cell.life.label.text = [NSString stringWithFormat:@" %@",foodRaw.life];
    }
    if (foodRaw.hunger.floatValue>0) {
        cell.hunger.label.text = [NSString stringWithFormat:@" +%@",foodRaw.hunger];
    }else{
        cell.hunger.label.text = [NSString stringWithFormat:@" %@",foodRaw.hunger];
    }
    if (foodRaw.sanity.floatValue>0) {
        cell.sanity.label.text = [NSString stringWithFormat:@" +%@",foodRaw.sanity];
    }else{
        cell.sanity.label.text = [NSString stringWithFormat:@" %@",foodRaw.sanity];
    }
    if (foodRaw.badCycle.floatValue != 0) {
        cell.badCycle.label.text = [NSString stringWithFormat:@"%@天",foodRaw.badCycle];
    }else{
        cell.badCycle.label.text = [NSString stringWithFormat:@"不腐烂"];
    }
    return cell;
}


@end
