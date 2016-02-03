//
//  BossCVC.m
//  DontStarve
//
//  Created by 李建国 on 16/1/12.
//  Copyright © 2016年 李建国. All rights reserved.
//
#import "BossCVC.h"
#import "BossModel.h"
#import "BossCell.h"
#import "Boss+CoreDataProperties.h"
#import "BossDetailCVC.h"
@interface BossCVC ()

@end

@implementation BossCVC

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.viewModel = [[BossModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"BOSS列表";
    [self.viewModel downloadData];
    [self bindWithReactive];
    [self.collectionView registerClass:[BossCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel getCount];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width/3, self.view.frame.size.width/3);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BossCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderColor = FlatGreenDark.CGColor;
    cell.layer.borderWidth = 1;
    
    Boss *boss = [self.viewModel getObject:indexPath.row];
    [self setImageView:cell.image urlStr:boss.urlStr];
    cell.name.text = boss.chName;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Boss *boss = [self.viewModel getObject:indexPath.row];
    CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc]init];
    BossDetailCVC *bossDetail = [[BossDetailCVC alloc]initWithCollectionViewLayout:layout boss:boss];
    [self.navigationController pushViewController:bossDetail animated:YES];
}

- (void)dealloc{
    NSLog(@"BossCVC");
}

@end
